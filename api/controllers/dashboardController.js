const db = require('../config/db');
const axios = require('axios');
require('dotenv').config();

const EXCHANGE_RATE_API_KEY = process.env.EXCHANGE_RATE_API_KEY;


const YAHOO_FINANCE_URL = 'https://query1.finance.yahoo.com/v8/finance/chart/BZ=F';
const EXCHANGE_RATE_URL = 'https://open.er-api.com/v6/latest/USD';

const getFuelExchangeTrends = async (req, res) => {
  try {
    const days = req.params.days ? parseInt(req.params.days) : 30;

    const currentDate = new Date();
    const pastDate = new Date(currentDate);
    pastDate.setDate(currentDate.getDate() - days + 1); 

    const allDates = [];
    for (let i = 0; i < days; i++) {
      const date = new Date(pastDate);
      date.setDate(pastDate.getDate() + i);
      allDates.push(date.toISOString().split('T')[0]);
    }

    const currentTimestamp = Math.floor(currentDate.getTime() / 1000);
    const pastTimestamp = Math.floor(pastDate.getTime() / 1000);
    const fuelResponse = await axios.get(`${YAHOO_FINANCE_URL}?period1=${pastTimestamp}&period2=${currentTimestamp}&interval=1d`);
    const fuelData = fuelResponse.data.chart?.result?.[0];

    if (!fuelData || !fuelData.indicators?.quote?.[0]?.close) {
      throw new Error('Petrol fiyatları çekilemedi.');
    }

    const fuelMap = {};
    fuelData.timestamp.forEach((timestamp, index) => {
      const date = new Date(timestamp * 1000).toISOString().split('T')[0];
      fuelMap[date] = fuelData.indicators.quote[0].close[index];
    });

    const exchangeResponse = await axios.get(`${EXCHANGE_RATE_URL}?apikey=${EXCHANGE_RATE_API_KEY}`);
    const exchangeData = exchangeResponse.data;

    if (!exchangeData || exchangeData.result !== 'success' || !exchangeData.rates?.TRY) {
      throw new Error('Döviz kuru çekilemedi.');
    }

    const fuelPrices = allDates.map(date => ({
      date,
      price: fuelMap[date] ?? null
    }));

    const exchangeRates = allDates.map(date => ({
      date,
      rate: exchangeData.rates.TRY
    }));

    res.json({
      fuel_prices: fuelPrices,
      exchange_rate: exchangeRates
    });

  } catch (error) {
    console.error('Hata:', error.message);
    res.status(500).json({ error: 'Veri alınamadı', details: error.message });
  }
};

const getAllRoutes = (req, res) => {
  try {
    const query = `
      SELECT 
        flight_id AS id,
        CONCAT(departure_city, '-', arrival_city) AS route
      FROM flights
      ORDER BY departure_city, arrival_city
    `;

    db.query(query, (err, results) => {
      if (err) {
        console.error('SQL sorgusu hatası:', err);
        return res.status(500).json({ error: 'Veritabanı hatası' });
      }

      if (results.length === 0) {
        return res.status(404).json({ message: 'Rota bulunamadı.' });
      }

      res.json(results);
    });

  } catch (error) {
    console.error('Hata:', error);
    res.status(500).json({ error: 'Sunucu hatası' });
  }
};



const getCompetitorPrices = async (req, res) => {
    try {
        const flightId = req.params.flight_id;

        const query = `
            SELECT 
                cp.competitor_name,
                cp.price,
                CONCAT(f.departure_city, '-', f.arrival_city) AS route
            FROM 
                competitor_prices cp
            INNER JOIN 
                flights f ON cp.flight_id = f.flight_id
            WHERE 
                cp.flight_id = ?
        `;

        db.query(query, [flightId], (err, results) => {
            if (err) {
                console.error('SQL sorgusu hatası:', err);
                return res.status(500).json({ error: 'Veritabanı hatası' });
            }

            if (results.length === 0) {
                return res.status(404).json({ message: 'Bu uçuş için rakip fiyatı bulunamadı.' });
            }
            
            res.json(results);
        });
    } catch (error) {
        console.error('Hata:', error);
        res.status(500).json({ error: 'Sunucu hatası' });
    }
};

const getAverageOccupancyRates = async (req, res) => {
    try {
        const query = `
            SELECT 
                f.flight_id,
                f.flight_number,
                f.departure_city,
                f.arrival_city,
                f.capacity,
                COALESCE(SUM(s.number_of_tickets), 0) AS sold_tickets,
                ROUND((COALESCE(SUM(s.number_of_tickets), 0) / f.capacity) * 100, 2) AS occupancy_rate
            FROM 
                flights f
            LEFT JOIN 
                sales s ON f.flight_id = s.flight_id
            GROUP BY 
                f.flight_id, f.flight_number, f.departure_city, f.arrival_city, f.capacity
        `;

        db.query(query, (err, results) => {
            if (err) {
                console.error('Doluluk oranları alınamadı:', err);
                return res.status(500).json({ error: 'Veri alınamadı' });
            }

            res.json({ occupancyRates: results });
        });
    } catch (error) {
        console.error('Hata:', error);
        res.status(500).json({ error: 'Sunucu hatası' });
    }
};

const getFlightsByOccupancy = async (req, res) => {
    try {
        const { type = 'highest' } = req.params; 
        if (type !== 'highest' && type !== 'lowest') {
            return res.status(400).json({ error: 'Geçersiz parametre. "highest" veya "lowest" kullanın.' });
        }

        const order = type === 'highest' ? 'DESC' : 'ASC';

        const query = `
            SELECT 
                f.flight_id,
                f.flight_number,
                f.departure_city,
                f.arrival_city,
                f.capacity,
                COALESCE(SUM(s.number_of_tickets), 0) AS sold_tickets,
                ROUND((COALESCE(SUM(s.number_of_tickets), 0) / f.capacity) * 100, 2) AS occupancy_rate
            FROM 
                flights f
            LEFT JOIN 
                sales s ON f.flight_id = s.flight_id
            GROUP BY 
                f.flight_id, f.flight_number, f.departure_city, f.arrival_city, f.capacity
            ORDER BY 
                occupancy_rate ${order}
            LIMIT 5
        `;

        db.query(query, (err, results) => {
            if (err) {
                console.error('Uçuşlar alınamadı:', err);
                return res.status(500).json({ error: 'Veri alınamadı' });
            }

            res.json({ flights: results });
        });
    } catch (error) {
        console.error('Hata:', error);
        res.status(500).json({ error: 'Sunucu hatası' });
    }
};

const getCustomerSatisfactionScores = async (req, res) => {
    try {
        const query = `
            SELECT 
                membership_type,
                COUNT(customer_id) AS total_customers,
                AVG(loyalty_score) AS avg_loyalty_score
            FROM 
                customers
            GROUP BY 
                membership_type
        `;

        db.query(query, (err, results) => {
            if (err) {
                console.error('Müşteri verileri alınamadı:', err);
                return res.status(500).json({ error: 'Veri alınamadı' });
            }
            const satisfactionScores = results.map(row => ({
                membership_type: row.membership_type,
                total_customers: row.total_customers,
                avg_loyalty_score: parseFloat(row.avg_loyalty_score).toFixed(2)
            }));

            res.json({ satisfactionScores });
        });
    } catch (error) {
        console.error('Hata:', error);
        res.status(500).json({ error: 'Sunucu hatası' });
    }
};

const getAllFlightPrices = async (req, res) => {
    try {
        const query = `
            SELECT flight_id, CONCAT(departure_city, '-', arrival_city) AS route, price
    FROM flights;
        `;

        db.query(query, (err, results) => {
            if (err) {
                console.error('Fiyat verileri alınamadı:', err);
                return res.status(500).json({ error: 'Veri alınamadı' });
            }

            const flightPrices = results.map(row => ({
            flight_id: row.flight_id,
            route: row.route,
            price: parseFloat(row.price).toFixed(2)
            }));

            res.json({ flightPrices });
        });
    } catch (error) {
        console.error('Hata:', error);
        res.status(500).json({ error: 'Sunucu hatası' });
    }
};


const getSuggestedPrice = async (req, res) => {
  try {
    const flightId = req.params.flight_id;

    const query = `
      SELECT price
      FROM competitor_prices
      WHERE flight_id = ?
    `;

    db.query(query, [flightId], (err, results) => {
      if (err) {
        console.error('SQL hatası:', err);
        return res.status(500).json({ error: 'Veritabanı hatası' });
      }

      if (!results || results.length === 0) {
        return res.status(404).json({ message: 'Bu uçuş için rakip fiyatı bulunamadı.' });
      }

      
      const prices = results.map(r => parseFloat(r.price));
      const avgPrice = prices.reduce((a, b) => a + b, 0) / prices.length;

      
      const suggestedPrice = parseFloat((avgPrice * 1.05).toFixed(2));

      res.json({
        flight_id: flightId,
        competitor_prices: prices,
        average_price: parseFloat(avgPrice.toFixed(2)),
        suggested_price: suggestedPrice
      });
    });

  } catch (error) {
    console.error('Hata:', error);
    res.status(500).json({ error: 'Sunucu hatası' });
  }
};


const calcDateRange = (period) => {
  const now = new Date();
  let start, end;
  end = new Date(now);
  end.setHours(23,59,59,999);

  if (!period || period === 'today') {
    start = new Date(now);
    start.setHours(0,0,0,0);
  } else if (period === '7d') {
    start = new Date(now);
    start.setDate(now.getDate() - 6); 
    start.setHours(0,0,0,0);
  } else if (period === '30d') {
    start = new Date(now);
    start.setDate(now.getDate() - 29); 
    start.setHours(0,0,0,0);
  } else if (period === 'month') {
    start = new Date(now.getFullYear(), now.getMonth(), 1);
  } else {
    
    start = new Date(now);
    start.setHours(0,0,0,0);
  }

  const format = d => d.toISOString().slice(0,19).replace('T',' ');
  return { start: format(start), end: format(end) };
};

const getOtp = async (req, res) => {
  try {
    const period = req.query.period || 'today';
    const { start, end } = calcDateRange(period);

  
    const query = `
      SELECT 
        COUNT(*) AS total_flights,
        SUM(CASE 
              WHEN actual_departure IS NOT NULL 
               AND TIMESTAMPDIFF(MINUTE, scheduled_departure, actual_departure) <= 15 
              THEN 1 ELSE 0 END) AS on_time_flights
      FROM flight_operations
      WHERE actual_departure IS NOT NULL
        AND scheduled_departure BETWEEN ? AND ?
    `;


    const startDate = new Date(start);
    const endDate = new Date(end);
    const diffMs = endDate - startDate;
    const prevEnd = new Date(startDate.getTime() - 1);
    const prevStart = new Date(prevEnd.getTime() - diffMs);
    const format = d => d.toISOString().slice(0,19).replace('T',' ');
    const prevStartStr = format(prevStart);
    const prevEndStr = format(prevEnd);

    db.query(query, [start, end], (err, results) => {
      if (err) {
        console.error('SQL hatası:', err);
        return res.status(500).json({ error: 'Veritabanı hatası' });
      }

      const total = results[0].total_flights || 0;
      const onTime = results[0].on_time_flights || 0;
      const otp = total > 0 ? parseFloat(((onTime / total) * 100).toFixed(2)) : 0.00;

      
      db.query(query, [prevStartStr, prevEndStr], (err2, prevResults) => {
        if (err2) {
          console.error('SQL hatası (prev):', err2);
          return res.status(500).json({ error: 'Veritabanı hatası' });
        }
        const prevTotal = prevResults[0].total_flights || 0;
        const prevOnTime = prevResults[0].on_time_flights || 0;
        const prevOtp = prevTotal > 0 ? parseFloat(((prevOnTime / prevTotal) * 100).toFixed(2)) : 0.00;

        const delta = parseFloat((otp - prevOtp).toFixed(2));

        res.json({
          period,
          total_flights: total,
          on_time_flights: onTime,
          otp,
          previous_otp: prevOtp,
          delta
        });
      });
    });

  } catch (error) {
    console.error('Hata:', error);
    res.status(500).json({ error: 'Sunucu hatası' });
  }
};

const getAnnualRevenue = async (req, res) => {
  try {
    const query = `
      SELECT 
        YEAR(sale_date) as year,
        SUM(total_revenue) as total_revenue
      FROM sales
      WHERE YEAR(sale_date) IN (YEAR(CURDATE()), YEAR(CURDATE()) - 1)
      GROUP BY YEAR(sale_date);
    `;

    db.query(query, (err, results) => {
      if (err) {
        console.error("SQL hatası:", err);
        return res.status(500).json({ error: "Veri alınamadı" });
      }

      let currentYear = new Date().getFullYear();
      let thisYearRevenue = 0;
      let lastYearRevenue = 0;

      results.forEach(r => {
        if (r.year === currentYear) thisYearRevenue = parseFloat(r.total_revenue);
        if (r.year === currentYear - 1) lastYearRevenue = parseFloat(r.total_revenue);
      });

      let delta = 0;
      if (lastYearRevenue > 0) {
        delta = ((thisYearRevenue - lastYearRevenue) / lastYearRevenue * 100).toFixed(2);
      }

      res.json({
        current_year: currentYear,
        this_year_revenue: thisYearRevenue,
        last_year_revenue: lastYearRevenue,
        delta: parseFloat(delta)
      });
    });
  } catch (error) {
    console.error("Hata:", error);
    res.status(500).json({ error: "Sunucu hatası" });
  }
};

const getRevenueByMonths = (req, res) => {
  try {
    
    const months = parseInt(req.query.months) || 1;

    const query = `
      SELECT 
        SUM(ticket_sales) AS ticket_sales,
        SUM(cargo_revenue) AS cargo_revenue,
        SUM(other_revenue) AS other_revenue
      FROM revenue
      WHERE date >= DATE_SUB(NOW(), INTERVAL ? MONTH)
    `;

    db.query(query, [months], (err, results) => {
      if (err) {
        console.error("SQL hatası:", err);
        return res.status(500).json({ error: "Veri alınamadı" });
      }

      const row = results[0] || { ticket_sales: 0, cargo_revenue: 0, other_revenue: 0 };

      res.json({
        months,
        ticket_sales: parseFloat(row.ticket_sales),
        cargo_revenue: parseFloat(row.cargo_revenue),
        other_revenue: parseFloat(row.other_revenue)
      });
    });

  } catch (error) {
    console.error("Hata:", error);
    res.status(500).json({ error: "Sunucu hatası" });
  }
};

const getCostByMonths = (req, res) => {
  try {
    
    const months = parseInt(req.query.months) || 1; 

    const query = `
      SELECT 
        SUM(fuel_cost) AS fuel_cost,
        SUM(staff_cost) AS staff_cost,
        SUM(maintenance_cost) AS maintenance_cost,
        SUM(other_costs) AS other_costs
      FROM flight_costs
      WHERE date >= DATE_SUB(NOW(), INTERVAL ? MONTH)
    `;

    db.query(query, [months], (err, results) => {
      if (err) {
        console.error("SQL hatası:", err);
        return res.status(500).json({ error: "Veri alınamadı" });
      }

      const row = results[0] || { fuel_cost: 0, staff_cost: 0, maintenance_cost: 0, other_costs: 0 };

      res.json({
        months,
        fuel_cost: parseFloat(row.fuel_cost),
        staff_cost: parseFloat(row.staff_cost),
        maintenance_cost: parseFloat(row.maintenance_cost),
        other_costs: parseFloat(row.other_costs)
      });
    });

  } catch (error) {
    console.error("Hata:", error);
    res.status(500).json({ error: "Sunucu hatası" });
  }
};


module.exports = {getOtp,getCostByMonths,getRevenueByMonths,getAnnualRevenue,getFuelExchangeTrends,getSuggestedPrice,getAllFlightPrices,getAverageOccupancyRates,getAllRoutes,getFlightsByOccupancy,getCustomerSatisfactionScores,getCompetitorPrices};
