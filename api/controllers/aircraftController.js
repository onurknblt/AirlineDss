const db = require('../config/db');
const axios = require('axios');

const getAircraftModels = (req, res) => {
  db.query(
    'SELECT aircraft_model FROM aircraft_factors ORDER BY aircraft_model',
    (err, results) => {
      if (err) {
        console.error('Uçak modelleri alınamadı:', err);
        return res.status(500).json({ error: 'Veri alınamadı' });
      }

      const models = results.map(r => r.aircraft_model);
      res.json(models);
    }
  );
};

module.exports = { getAircraftModels };
