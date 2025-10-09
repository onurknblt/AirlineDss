const db = require('../config/db');
const axios = require('axios');
const moment = require('moment');

const getRevenueForecastByFlightId = async (req, res) => {
  const flightId = req.params.flight_id;

  try {
    const combinedQuery = `
      WITH MonthlyFinancials AS (
        SELECT
          DATE_FORMAT(r.date, '%Y-%m-01') AS month,
          SUM(r.ticket_sales) AS ticket_sales,
          SUM(r.cargo_revenue) AS cargo_revenue,
          SUM(r.other_revenue) AS other_revenue,
          SUM(fc.fuel_cost) AS fuel_cost,
          SUM(fc.staff_cost) AS staff_cost,
          SUM(fc.maintenance_cost) AS maintenance_cost,
          SUM(fc.other_costs) AS other_costs
        FROM Revenue r
        LEFT JOIN Flight_Costs fc ON r.flight_id = fc.flight_id AND DATE_FORMAT(r.date, '%Y-%m') = DATE_FORMAT(fc.date, '%Y-%m')
        WHERE r.flight_id = ?
        GROUP BY month
      ),
      MonthlyExternals AS (
        SELECT
          DATE_FORMAT(f.price_date, '%Y-%m-01') AS month,
          AVG(f.price) AS brent_price,
          AVG(CASE WHEN e.currency = 'USD' THEN e.rate ELSE NULL END) AS usd_try_rate
        FROM fuel_prices f
        LEFT JOIN exchange_rates e ON DATE_FORMAT(f.price_date, '%Y-%m') = DATE_FORMAT(e.rate_date, '%Y-%m')
        GROUP BY month
      )
      SELECT
        mf.month,
        mf.ticket_sales, mf.cargo_revenue, mf.other_revenue,
        mf.fuel_cost, mf.staff_cost, mf.maintenance_cost, mf.other_costs,
        me.brent_price, me.usd_try_rate,
        CASE WHEN MONTH(mf.month) IN (6, 7, 8) THEN 1 ELSE 0 END AS is_summer_season
      FROM MonthlyFinancials mf
      LEFT JOIN MonthlyExternals me ON mf.month = me.month
      WHERE mf.month IS NOT NULL
      ORDER BY mf.month;
    `;

    const [results] = await db.promise().query(combinedQuery, [flightId]);

    if (results.length < 24) {
      return res.status(400).json({ 
          message: 'Tahmin için yetersiz veri.',
          error: `Modelin çalışması için en az 24 aylık veri gereklidir, ancak sadece ${results.length} aylık veri bulundu.` 
      });
    }

    const financialData = results.map(row => ({
      date: moment(row.month).format('YYYY-MM-DD'),
      ticket_sales: parseFloat(row.ticket_sales || 0),
      cargo_revenue: parseFloat(row.cargo_revenue || 0),
      other_revenue: parseFloat(row.other_revenue || 0),
      fuel_cost: parseFloat(row.fuel_cost || 0),
      staff_cost: parseFloat(row.staff_cost || 0),
      maintenance_cost: parseFloat(row.maintenance_cost || 0),
      other_costs: parseFloat(row.other_costs || 0)
    }));

    const externalFactors = results.map(row => ({
        date: moment(row.month).format('YYYY-MM-DD'),
        brent_price: parseFloat(row.brent_price || 85.0),
        usd_try_rate: parseFloat(row.usd_try_rate || 40.0),
        is_summer_season: parseInt(row.is_summer_season),
        gdp_growth_target_country: 2.5
    }));

    const response = await axios.post('http://localhost:5001/forecast', {
      flight_id: flightId,
      financial_data: financialData,
      external_factors: externalFactors
    }, { headers: { 'Content-Type': 'application/json' } });

    res.json(response.data);

  } catch (error) {
    // --- Geliştirilmiş Hata Yakalama Bloğu ---
    console.error('Gelir Tahmin Servisi Hatası:', error); // Tam hatayı konsola yazdır

    let errorMessage = 'Bilinmeyen bir sunucu hatası oluştu.';
    
    // Python servisinden gelen bir hata mı?
    if (error.response) {
      const pythonError = error.response.data.error || 'Python servisinden detaylı hata mesajı alınamadı.';
      errorMessage = `Python tahmin servisi bir hata döndürdü: ${pythonError}`;
    } 
    // Python servisine ulaşılamıyor mu?
    else if (error.request) {
      errorMessage = 'Python tahmin servisine ulaşılamadı. Servisin (localhost:5001) çalıştığından emin olun.';
    } 
    // Başka bir hata mı oluştu?
    else {
      errorMessage = error.message;
    }

    res.status(500).json({
      message: 'Gelir tahmin verileri alınamadı',
      error: errorMessage // Artık detaylı hata mesajı dönecek
    });
  }
};

const getInternalStrategyToday = (req, res) => {
  try {
    const query = `
      SELECT 
        action_title, description, aircraft_model, tail_number, 
        action_date, priority, notes
      FROM internal_strategy_actions
      WHERE action_date = CURDATE()
      ORDER BY 
        CASE priority          
          WHEN 'High' THEN 1          
          WHEN 'Medium' THEN 2          
          WHEN 'Low' THEN 3          
          ELSE 4        
        END ASC
    `;
    db.query(query, (err, results) => {
      if (err) {
        console.error("SQL hatası:", err);
        return res.status(500).json({ error: "Veri alınamadı" });
      }
      res.json(results || []);
    });
  } catch (error) {
    console.error("Hata:", error);
    res.status(500).json({ error: "Sunucu hatası" });
  }
};

module.exports = { 
  getRevenueForecastByFlightId,
  getInternalStrategyToday 
};

