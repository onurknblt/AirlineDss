const express = require('express');
const router = express.Router();
const aircraftController = require('../controllers/aircraftController');

router.get('/', aircraftController.getAircraftModels); // Tüm uçak modellerini alır

module.exports = router;
