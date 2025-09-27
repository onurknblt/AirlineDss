const db = require('../config/db');
const axios = require('axios');

const getDemandForecastByFlightId = async (req, res) => {
  const flightId = req.params.flight_id;

  try {

    const results = await new Promise((resolve, reject) => {
      db.query('SELECT sale_date, number_of_tickets FROM Sales WHERE flight_id = ?', [flightId], (err, results) => {
        if (err) {
          return reject(err);
        }
        resolve(results);
      });
    });

    if (results.length === 0) {
      return res.status(404).json({ message: 'Bu uçuş için satış verisi bulunamadı' });
    }

    
    const salesData = results.map(row => ({
      sale_date: row.sale_date.toISOString(), 
      number_of_tickets: row.number_of_tickets
    }));

    
    const response = await axios.post('http://localhost:5000/predict', {
      flight_id: flightId,
      sales_data: salesData
    }, {
      headers: { 'Content-Type': 'application/json' }
    });

    
    if (response.data.error) {
      return res.status(400).json({
        flight_id: flightId,
        error: response.data.error
      });
    }

    res.json(response.data);
  } catch (error) {
    console.error('Tahmin servisi hatası:', error.response ? error.response.data : error.message);
    res.status(500).json({
      message: 'Tahmin verileri alınamadı',
      error: error.response ? error.response.data : error.message
    });
  }
};


const getAllRoutes = async (req, res) => {
    try {
        const query = 
        `SELECT 
            flight_id, 
            CONCAT(departure_city, ' - ', arrival_city) AS route
            FROM flights;`;

        db.query(query, (err, results) => {
            if (err) {
                console.error('Rotalar alınamadı:', err);
                return res.status(500).json({ error: 'Veri alınamadı' });
            }

            const routes = results.map(row => ({
                flight_id: row.flight_id,
                route: row.route
            }));

            res.json({ routes });
        });
    } catch (error) {
        console.error('Hata:', error);
        res.status(500).json({ error: 'Sunucu hatası' });
    }
};


const getTicketTimingByFlightId = async (req, res) => {
    const { flight_id } = req.params;

    if (!flight_id) {
        return res.status(400).json({ error: 'flight_id gerekli' });
    }

    try {
        const query = `
            SELECT t.booking_date, f.departure_date
            FROM tickets t
            JOIN flights f ON t.flight_id = f.flight_id
            WHERE t.flight_id = ?;
        `;

        db.query(query, [flight_id], (err, results) => {
            if (err) {
                console.error('Bilet verileri alınamadı:', err);
                return res.status(500).json({ error: 'Bilet verileri alınamadı' });
            }

            if (results.length === 0) {
                return res.status(404).json({ error: 'Bu uçuş için bilet bulunamadı' });
            }

            
            const earlyThreshold = 30;
            const lastMinuteThreshold = 7;

            let total = results.length;
            let earlyCount = 0;
            let lastMinuteCount = 0;
            let histogram = {};

            results.forEach(row => {
                const bookingDate = new Date(row.booking_date);
                const departureDate = new Date(row.departure_date);
                const diffDays = Math.ceil((departureDate - bookingDate) / (1000*60*60*24));

                
                histogram[diffDays] = (histogram[diffDays] || 0) + 1;

                
                if (diffDays >= earlyThreshold) earlyCount++;
                if (diffDays < lastMinuteThreshold) lastMinuteCount++;
            });

            const earlyPct = ((earlyCount / total) * 100).toFixed(2);
            const lastMinutePct = ((lastMinuteCount / total) * 100).toFixed(2);

            
            let messages = [];
            if (earlyPct >= 70) messages.push('Erken fiyat artışı uygulanabilir.');
            if (lastMinutePct >= 50) messages.push('Rota son dakika ağırlıklı, erken promosyon gereksiz olabilir.');

            res.json({
                total_tickets: total,
                early_pct: earlyPct,
                last_minute_pct: lastMinutePct,
                messages,
                histogram_data: Object.entries(histogram).map(([days, count]) => ({ days_before_flight: parseInt(days), ticket_count: count }))
            });
        });

    } catch (error) {
        console.error('Hata:', error);
        res.status(500).json({
            message: 'Bilet analiz verileri alınamadı',
            error: error.message
        });
    }
};


module.exports = { getDemandForecastByFlightId,getAllRoutes,getTicketTimingByFlightId};
