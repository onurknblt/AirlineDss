const express = require('express');
const router = express.Router();
const demandController = require('../controllers/demandController');

router.get('/:flight_id/forecast', demandController.getDemandForecastByFlightId); //Belirli bir uçuşun talep tahminlerini getirir.
router.get('/routes', demandController.getAllRoutes); //Tüm uçuş rotalarını getirir.
router.get('/ticket-timing/:flight_id', demandController.getTicketTimingByFlightId); //Belirli bir uçuşun biletleme zamanlamasını getirir.

module.exports = router;
