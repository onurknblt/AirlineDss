import flask
from flask import request, jsonify
import pandas as pd
import numpy as np
import pmdarima as pm
from statsmodels.tsa.statespace.sarimax import SARIMAX
from sklearn.preprocessing import StandardScaler
import logging
import warnings
from typing import Tuple

# Uyarıları bastır (gerektiğinde aç)
warnings.filterwarnings("ignore")

app = flask.Flask(__name__)
app.config["DEBUG"] = True
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")


def safe_to_numeric_df(df: pd.DataFrame) -> pd.DataFrame:
    """Tüm sütunları sayısala çevirir; mümkün olmayanlar NaN olur."""
    for c in df.columns:
        df[c] = pd.to_numeric(df[c], errors="coerce")
    return df


def prepare_full_df(financial_df: pd.DataFrame, external_df: pd.DataFrame) -> pd.DataFrame:
    """
    Tarih indexleme, join, aylık resample ve boşluk doldurma işlemleri.
    Dönüş: aylık hizalı, sayısal ve temizlenmiş DataFrame.
    """
    # Tarih kolonlarını datetime yap
    financial_df['date'] = pd.to_datetime(financial_df['date'])
    external_df['date'] = pd.to_datetime(external_df['date'])

    financial_df.set_index('date', inplace=True)
    external_df.set_index('date', inplace=True)

    full = financial_df.join(external_df, how='left')

    # Aylık hizalama: ay sonuna göre (freq='M')
    full = full.resample('M').mean(numeric_only=True)

    # Sayısal dönüşümler
    full = safe_to_numeric_df(full)

    # Zaman bazlı interpolasyon + kalan NaN'ları sütun ortalaması ile doldur
    full.interpolate(method='time', inplace=True)
    full.fillna(full.mean(numeric_only=True), inplace=True)

    # Toplam gelir ve maliyet sütunları (eksikse 0 kabul edilecek)
    full['total_revenue'] = (
        full.get('ticket_sales', 0).fillna(0) +
        full.get('cargo_revenue', 0).fillna(0) +
        full.get('other_revenue', 0).fillna(0)
    )
    full['total_cost'] = (
        full.get('fuel_cost', 0).fillna(0) +
        full.get('staff_cost', 0).fillna(0) +
        full.get('maintenance_cost', 0).fillna(0)
    )

    # Son bir temizlik: sayısal olmayanları NaN yap ve ortalama ile doldur
    full = safe_to_numeric_df(full)
    full.fillna(full.mean(numeric_only=True), inplace=True)

    return full


def build_future_exog(full_df: pd.DataFrame, exog_vars: list, forecast_steps: int, scaler: StandardScaler = None) -> Tuple[pd.DataFrame, StandardScaler]:
    """
    full_df'in son tarihinden başlayarak forecast_steps boyunca dış değişken DataFrame'i üretir.
    Varsayılan: exog için son değerleri tekrar eder. is_summer_season dinamik olarak ayarlanır.
    Eğer scaler verilmediyse, fonksiyon kendi scaler'ını döndürür.
    """
    last_date = full_df.index[-1]
    future_index = pd.date_range(start=last_date + pd.offsets.MonthEnd(1), periods=forecast_steps, freq='M')
    future_exog = pd.DataFrame(index=future_index)

    # Eğer bazı exog sütunları full_df'de yoksa 0 ile doldur
    for var in exog_vars:
        if var in full_df.columns and not full_df[var].isna().all():
            val = float(full_df[var].iloc[-1])
        else:
            val = 0.0
        future_exog[var] = [val] * forecast_steps

    # is_summer_season'ı ay bilgisine göre güncelle
    future_exog['is_summer_season'] = future_exog.index.month.isin([6, 7, 8]).astype(int)

    # Standardize et (scaler yoksa oluştur)
    if scaler is None:
        scaler = StandardScaler()
        # Fit scaler on historical exog values (dropna safe)
        hist_exog = full_df[exog_vars].fillna(method='ffill').fillna(method='bfill').fillna(0.0)
        scaler.fit(hist_exog.values)
    # Transform future exog
    future_exog_vals = scaler.transform(future_exog[exog_vars].values)
    future_exog_scaled = pd.DataFrame(future_exog_vals, index=future_exog.index, columns=exog_vars)

    # is_summer_season tekrar ekle (scaler dönüştürdüğü için boolean korumak istersen ayrı bırakabilirsin;
    # burada scaler'e dahil ettiğimiz için bu satırı kaldırdık. Eğer is_summer_season binary ve scaler'e dahil etmek istemiyorsan:
    # future_exog_scaled['is_summer_season'] = future_exog['is_summer_season'].values
    return future_exog_scaled, scaler


def get_best_model_and_forecast(series: pd.Series, exog: pd.DataFrame, future_exog: pd.DataFrame, forecast_steps: int):
    """
    series: MODEL'DE KULLANILACAK SERİ (dönüştürülmüş - örn log1p)
    exog: aynı index'e sahip geçmiş exogenous (scale edilmiş)
    future_exog: scale edilmiş future exogenous
    döndürür: fitted model ve forecast_result (statsmodels result)
    """
    # Auto-ARIMA parametreleri
    auto_model = pm.auto_arima(
        series,
        exogenous=exog,
        start_p=1, start_q=1,
        test='adf',
        max_p=3, max_q=3,
        m=12,
        d=None,
        seasonal=True,
        start_P=0,
        D=1,
        trace=False,
        error_action='ignore',
        suppress_warnings=True,
        stepwise=True
    )

    logging.info(f"ARIMA seçildi: order={auto_model.order}, seasonal_order={auto_model.seasonal_order}")

    final = SARIMAX(
        series,
        exog=exog,
        order=auto_model.order,
        seasonal_order=auto_model.seasonal_order,
        enforce_stationarity=False,
        enforce_invertibility=False
    )
    fitted = final.fit(disp=False)
    forecast_res = fitted.get_forecast(steps=forecast_steps, exog=future_exog)
    return fitted, forecast_res, auto_model.order, auto_model.seasonal_order


def inverse_transform_forecast(pred_mean: np.ndarray, conf_int: pd.DataFrame):
    """
    Log1p ile dönüştürülmüş tahminler için geri dönüşüm (expm1).
    Ayrıca alt sınırı 0'ın altına düşenleri 0'a clamp eder (işletme mantığı).
    """
    rev = np.expm1(pred_mean)  # predicted_mean array-like
    lower = np.expm1(conf_int.iloc[:, 0].values)
    upper = np.expm1(conf_int.iloc[:, 1].values)

    # Sayısal stabilite: negatifleri sıfıra çek
    rev = np.maximum(rev, 0.0)
    lower = np.maximum(lower, 0.0)
    upper = np.maximum(upper, 0.0)

    return rev, lower, upper


def forecast_financials_advanced(financial_data, external_factors, forecast_steps=12):
    try:
        # VeriFrame'leri oluştur
        df = pd.DataFrame(financial_data)
        exog_df = pd.DataFrame(external_factors)

        # Temizlik & hazırlık
        full_df = prepare_full_df(df, exog_df)

        # Yeterlilik kontrolü
        if len(full_df) < 24:
            return {'error': f'Yetersiz veri: en az 24 aylık veri önerilir. Mevcut: {len(full_df)} ay.'}

        # Dış değişkenler
        exog_vars = ['brent_price', 'usd_try_rate', 'is_summer_season', 'gdp_growth_target_country']

        # Eksik exog varsa sütun ekle
        for v in exog_vars:
            if v not in full_df.columns:
                full_df[v] = 0.0

        # Standartlaştırıcıyı oluştur ve future_exog elde et
        scaler = StandardScaler()
        hist_exog = full_df[exog_vars].fillna(method='ffill').fillna(method='bfill').fillna(0.0)
        scaler.fit(hist_exog.values)

        future_exog_scaled, _ = build_future_exog(full_df, exog_vars, forecast_steps, scaler=scaler)

        # Modelleme için X (exog) historical scaled
        hist_exog_scaled_vals = scaler.transform(hist_exog.values)
        hist_exog_scaled = pd.DataFrame(hist_exog_scaled_vals, index=hist_exog.index, columns=exog_vars)

        # Log dönüşümü: gelir & maliyet (pozitif veri sağlanmış olmalı; 0 için log1p uygun)
        revenue_series = np.log1p(full_df['total_revenue'].astype(float).fillna(0.0))
        cost_series = np.log1p(full_df['total_cost'].astype(float).fillna(0.0))

        # MODELLERİ ÇALIŞTIR
        rev_fitted, rev_forecast_res, rev_order, rev_seasonal = get_best_model_and_forecast(
            revenue_series, hist_exog_scaled, future_exog_scaled, forecast_steps
        )
        cost_fitted, cost_forecast_res, cost_order, cost_seasonal = get_best_model_and_forecast(
            cost_series, hist_exog_scaled, future_exog_scaled, forecast_steps
        )

        # Tahminleri ters çevir (expm1) ve güven aralıklarını işle
        rev_pred_mean = rev_forecast_res.predicted_mean
        rev_conf = rev_forecast_res.conf_int()
        cost_pred_mean = cost_forecast_res.predicted_mean
        cost_conf = cost_forecast_res.conf_int()

        rev_vals, rev_lower, rev_upper = inverse_transform_forecast(rev_pred_mean, rev_conf)
        cost_vals, cost_lower, cost_upper = inverse_transform_forecast(cost_pred_mean, cost_conf)

        # Tarihler ve sonuç yapılandırma
        future_dates = future_exog_scaled.index.strftime('%Y-%m').tolist()
        results = {'forecast_period': future_dates, 'kpis': [], 'model_info': {}}

        # Model bilgisi (kısa)
        results['model_info']['revenue_model'] = {'order': str(rev_order), 'seasonal_order': str(rev_seasonal)}
        results['model_info']['cost_model'] = {'order': str(cost_order), 'seasonal_order': str(cost_seasonal)}

        for i in range(forecast_steps):
            revenue = float(np.round(rev_vals[i], 2))
            cost = float(np.round(cost_vals[i], 2))
            lower_r = float(np.round(rev_lower[i], 2))
            upper_r = float(np.round(rev_upper[i], 2))
            lower_c = float(np.round(cost_lower[i], 2))
            upper_c = float(np.round(cost_upper[i], 2))

            # İşletme mantığı: negatifleri zaten clamp ettik; güven aralıkları da 0 altı değil
            profit = float(np.round(revenue - cost, 2))
            margin = None
            if revenue > 0:
                margin = float(np.round((profit / revenue) * 100, 2))

            results['kpis'].append({
                'month': future_dates[i],
                'revenue_forecast': {'expected': revenue, 'lower_bound': lower_r, 'upper_bound': upper_r},
                'cost_forecast': {'expected': cost, 'lower_bound': lower_c, 'upper_bound': upper_c},
                'profit_forecast': profit,
                'profit_margin_percent': margin
            })

        # Otomatik insight: üçten fazla düşük marj (örnek eşik %5)
        low_margin_months = [k['month'] for k in results['kpis'] if k['profit_margin_percent'] is not None and k['profit_margin_percent'] < 5]
        if len(low_margin_months) > 2:
            results['automated_insight'] = (
                f"Uyarı: {', '.join(low_margin_months)} aylarında kâr marjı %5'in altına düşebilir. "
                "Maliyet optimizasyonu veya fiyat stratejisi önerilir."
            )

        return results

    except Exception as e:
        logging.exception("Tahmin sırasında beklenmeyen hata oluştu.")
        return {'error': f'Tahmin sırasında bir hata oluştu: {str(e)}'}


@app.route('/forecast', methods=['POST'])
def predict():
    data = request.get_json(force=True, silent=True)
    if not data:
        return jsonify({'error': 'Eksik veya hatalı JSON'}), 400

    flight_id = data.get('flight_id')
    financial_data = data.get('financial_data')
    external_factors = data.get('external_factors')

    if financial_data is None or external_factors is None:
        return jsonify({'flight_id': flight_id, 'error': 'Finansal veriler veya dış faktörler eksik'}), 400

    result = forecast_financials_advanced(financial_data, external_factors, forecast_steps=12)
    if 'error' in result:
        return jsonify({'flight_id': flight_id, 'error': result['error']}), 400

    return jsonify({'flight_id': flight_id, 'forecast_results': result}), 200


if __name__ == '__main__':
    # Local geliştirme için; prod ortamında WSGI (gunicorn/uwsgi) tercih edin.
    app.run(port=5001)