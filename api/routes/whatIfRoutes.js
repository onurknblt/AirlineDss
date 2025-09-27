const express = require('express');
const router = express.Router();
const whatIfController = require('../controllers/whatIfController');

router.post('/', whatIfController.calculateWhatIfScenario); // What-If senaryosu hesaplar

module.exports = router;