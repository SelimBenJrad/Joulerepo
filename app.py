from flask import Flask, request, jsonify
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
import pandas as pd

def create_model():
    # 1) build a tiny fake DataFrame
    data = pd.DataFrame({
        'type': ['Laptop', 'Machine', 'Vehicle', 'Laptop', 'Machine', 'Vehicle'] * 100,
        'usageHours': [200, 5000, 10000, 100, 6000, 12000] * 100,
        'ageYears': [1, 5, 10, 2, 6, 12] * 100,
        'maintenanceCount': [1, 5, 10, 0, 7, 15] * 100,
        'condition': ['good', 'bad', 'bad', 'good', 'bad', 'bad'] * 100
    })

    X = data.drop('condition', axis=1)
    y = data['condition']

    # 2) one-hot encode 'type', passthrough numericals
    preprocessor = ColumnTransformer(
        transformers=[('cat', OneHotEncoder(), ['type'])],
        remainder='passthrough'
    )

    # 3) pipeline + RF
    pipeline = Pipeline([
        ('pre', preprocessor),
        ('rf', RandomForestClassifier(random_state=42))
    ])

    # 4) fit & return
    pipeline.fit(X, y)
    return pipeline

# ─── Flask setup ────────────────────────────────────────────────────────────────
app = Flask(__name__)
model = create_model()   # train on start

@app.route('/predict', methods=['POST'])
def predict():
    """
    Expects JSON body with keys:
      - type: str
      - usageHours: int
      - ageYears: int
      - maintenanceCount: int
    Returns: {"condition": "good" or "bad"}
    """
    asset = request.get_json()
    df = pd.DataFrame([asset])          # single-row DataFrame
    pred = model.predict(df)[0]
    return jsonify({"condition": pred})

if __name__ == '__main__':
    app.run(debug=True, port=5000)
