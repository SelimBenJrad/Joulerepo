from flask import Flask, request, jsonify
import joblib
import pandas as pd
from datetime import datetime, timedelta

app = Flask(__name__)
model = joblib.load("asset_failure_prediction_model.pkl")

@app.route('/predict-failure-date', methods=['POST'])
def predict_failure_date():
    data = request.json
    input_data = pd.DataFrame([data])  # ✅ FIX: Convert to DataFrame
    predicted_days = model.predict(input_data)[0]
    failure_date = datetime.now() + timedelta(days=int(predicted_days))
    return jsonify({ "failureDate": failure_date.strftime("%Y-%m-%d") })

if __name__ == '__main__':
    app.run(debug=True, port=5000)
