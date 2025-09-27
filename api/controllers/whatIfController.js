const db = require('../config/db');
const axios = require('axios');


const calculateWhatIfScenario = (req, res) => {
  try {
    const {
      aircraft_model,
      investment_type,
      cost,
      occupancy,
      fuel_cost,
      other_costs,
      revenue
    } = req.body;

    
    if (
      !aircraft_model ||
      !investment_type ||
      isNaN(cost) ||
      isNaN(occupancy) ||
      isNaN(fuel_cost) ||
      isNaN(other_costs) ||
      isNaN(revenue)
    ) {
      return res.status(400).json({ error: "Eksik veya hatalı parametreler" });
    }

    
    db.query(
      "SELECT fuel_multiplier, maintenance_multiplier FROM aircraft_factors WHERE aircraft_model = ? LIMIT 1",
      [aircraft_model],
      (err, rows) => {
        if (err) {
          console.error("DB Hatası:", err);
          return res.status(500).json({ error: "Veritabanı hatası" });
        }

        const modelFactors = rows.length > 0
          ? rows[0]
          : { fuel_multiplier: 1, maintenance_multiplier: 1 };

        
        let effectiveCost;
        if (investment_type === "Satın Alma") {
          effectiveCost = parseFloat(cost);
        } else if (investment_type === "Leasing") {
          
          effectiveCost = parseFloat(cost) * 12;
        } else {
          effectiveCost = parseFloat(cost);
        }

        
        const adjustedFuel = parseFloat(fuel_cost) * parseFloat(modelFactors.fuel_multiplier);
        const adjustedOther = parseFloat(other_costs) * parseFloat(modelFactors.maintenance_multiplier);

        
        const loadFactor = parseFloat(occupancy) / 100;
        const adjustedRevenue = parseFloat(revenue) * loadFactor;

        
        const totalCost = effectiveCost + adjustedFuel + adjustedOther;
        const netProfit = adjustedRevenue - totalCost;

        const roi = totalCost > 0 ? ((netProfit / totalCost) * 100).toFixed(1) : 0;
        const npv = (netProfit * 0.9).toFixed(0); 
        const breakEven = netProfit > 0 ? (effectiveCost / netProfit).toFixed(1) : null;

        
        return res.json({
          aircraft_model,
          investment_type,
          adjusted_fuel_cost: adjustedFuel.toFixed(2),
          adjusted_other_costs: adjustedOther.toFixed(2),
          effective_cost: effectiveCost.toFixed(2),
          adjusted_revenue: adjustedRevenue.toFixed(2),
          net_profit: netProfit.toFixed(2),
          roi: parseFloat(roi),
          npv: parseInt(npv, 10),
          break_even_years: breakEven
        });
      }
    );

  } catch (error) {
    console.error("What-If hesaplama hatası:", error);
    res.status(500).json({ error: "Sunucu hatası" });
  }
};

module.exports = { calculateWhatIfScenario };
