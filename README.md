# AirlineDss – Airline Decision Support System

**AirlineDss**, hava yolu şirketlerinin **talep, gelir ve operasyon kararlarını desteklemek** için geliştirilmiş bir **karar destek sistemi (DSS)** projesidir. Proje, **backend (API)** ve **frontend (client)** olmak üzere Full Stack geliştirilmiştir.

---

## 🚀 Özellikler

- **Talep Analizi:** Yolcu talep tahmini ve senaryo analizi.
- **Gelir Yönetimi:** Farklı stratejiler ile gelir optimizasyonu.
- **Operasyon Modülleri:** Uçuş ve uçak yönetimi.
- **Simülasyon & What-if Analizleri:** Farklı uçak alım/kiralama senaryolarının sonuçlarını gözlemleyebilme.
- **Dashboard:** Genel bilgilendirici KPI'lar ve grafikler

---

## 🏗 Teknolojiler

### Backend (API)
- Node.js, Express.js
- REST API
- Flask API
- MySQL

### Frontend (Client)
- Chart.js / D3.js (grafikler için)
- Bootstrap Material Design
- Material Dashboard 3

### Diğer
- Monorepo yönetimi için `concurrently`
- `.gitignore` ile node_modules ve build dosyaları kontrol altında

---

## 📂 Proje Yapısı

```
AirlineDss/ # Proje kökü
├── api/ # Backend
│ ├── bin/ # Başlatma ve yardımcı dosyalar
│ ├── config/ # Db dosyaları
│ ├── controllers/ # API controller dosyaları
│ ├── flask/ # Flask uygulamasıyla ilgili dosyalar
│ ├── routes/ # API route dosyaları
│ ├── services/ # İş mantığı ve servis dosyaları
│ └── app.js # Backend ana dosyası
├── client/ # Frontend
│ ├── assets/ # Resimler, CSS, JS vb.
│ ├── pages/ # HTML sayfaları
│ ├── gulpfile.mjs # Frontend görev yöneticisi
│ └── template.html # Template dosyası
├── .gitignore # Git ignore dosyası
└── README.md # Proje tanıtım dosyası
```




---

# ⚙️ Kurulum

### 1. Repository’yi klonlayın
```
git clone https://github.com/onurknblt/AirlineDss.git
cd AirlineDss
```

### 2. Sanal ortamı kurun (venv) ve içerisine girin
```
python -m venv venv
venv\Scripts\activate
```

### 3. Frontend paket kurulumu
```
cd ../client
npm install
```

### 4. Backend paket kurulumu
```
cd ../api
npm install
```

### Monorepo yönetici package.json
```
cd ..
npm install
```

### Ana kök dizinde (venv) ayağa kaldır
```
npm start
```

