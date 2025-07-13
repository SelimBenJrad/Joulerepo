const cds = require('@sap/cds');
const fetch = require('node-fetch');

module.exports = cds.service.impl(async function() {
  const { Equipment } = this.entities;

  // Before CREATE and UPDATE handlers
  this.before(['CREATE', 'UPDATE'], Equipment, async (req) => {
    const { type, usageHours, ageYears, maintenanceCount } = req.data;
    // Only call API if all required fields are present
    if (type && usageHours != null && ageYears != null && maintenanceCount != null) {
      try {
        const response = await fetch('http://localhost:5000/predict-failure-date', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ type, usageHours, ageYears, maintenanceCount })
        });
        if (response.ok) {
          const result = await response.json();
          if (result.predictedFailureDate) {
            req.data.PredictedFailureDate = result.predictedFailureDate;
          }
        } else {
          console.error('API call failed:', await response.text());
        }
      } catch (err) {
        console.error('Error calling prediction API:', err);
      }
    }
  });
});
