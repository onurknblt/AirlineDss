const express = require('express');
const router = express.Router();
const dashboardController = require('../controllers/dashboardController');

router.get('/fuel-exchange-trends/:days?', dashboardController.getFuelExchangeTrends); //Brent Petrol ve USD/TRY kurlarının günlük değişimlerini getirir.
router.get('/flights-by-occupancy/:type?', dashboardController.getFlightsByOccupancy); //Uçuşların doluluk oranlarına göre sayılarını getirir.
router.get('/average-occupancy-rates', dashboardController.getAverageOccupancyRates); //Uçuşların ortalama doluluk oranlarını getirir.
router.get('/satisfaction-score', dashboardController.getCustomerSatisfactionScores); //Müşteri memnuniyet skorlarını getirir.
router.get('/competitor-prices/:flight_id', dashboardController.getCompetitorPrices); //Belirli bir uçuşun rakip fiyatlarını getirir.
router.get('/routes', dashboardController.getAllRoutes); //Tüm uçuş rotalarını getirir.
router.get('/all-prices', dashboardController.getAllFlightPrices); //Tüm rotaların kendimize ait fiyatlarını getirir.
router.get('/suggested-price/:flight_id', dashboardController.getSuggestedPrice); //Rota için fiyat önerisi.
router.get('/otp', dashboardController.getOtp); //zamanında kalkış oranı
router.get('/annual-revenue', dashboardController.getAnnualRevenue); //yıllık gelir
router.get('/revenue-by-months/:year?', dashboardController.getRevenueByMonths); //Aylara göre gelir
router.get('/cost-by-months', dashboardController.getCostByMonths);//Aylara göre maliyet
router.get('/map-data', dashboardController.getMapData); //Harita verisi (rotalar ve karlılık)
module.exports = router;