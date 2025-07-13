using jouleSrv as service from '../../srv/service';

annotate service.AssetMetricsAnalyticsSet with @(
    UI.SelectionFields: [
        asset_ID,
        recordedYear,
        recordedMonth
    ],
    UI.PresentationVariant: {
        GroupBy: [
            asset_ID,
            recordedYear,
            recordedMonth
        ],
        SortOrder: [
            {Property: recordedYear},
            {Property: recordedMonth}
        ]
    },
    UI.LineItem: [
        {
            Value: assetName,
            Label: 'Asset'
        },
        {
            Value: recordedYear,
            Label: 'Year'
        },
        {
            Value: recordedMonth,
            Label: 'Month'
        },
        {
            Value: operatingHours,
            Label: 'Operating Hours'
        },
        {
            Value: temperature,
            Label: 'Temperature'
        },
        {
            Value: vibrationLevel,
            Label: 'Vibration Level'
        },
        {
            Value: PredictionConfidence,
            Label: 'Prediction Confidence'
        }
    ],
    Analytics: {
        AggregatedProperties: [
            {
                Name: 'AverageTemperature',
                AggregationMethod: 'average',
                AggregatableProperty: 'temperature',
                ![@Common.Label]: 'Average Temperature'
            },
            {
                Name: 'TotalOperatingHours',
                AggregationMethod: 'sum',
                AggregatableProperty: 'operatingHours',
                ![@Common.Label]: 'Total Operating Hours'
            },
            {
                Name: 'AverageVibration',
                AggregationMethod: 'average',
                AggregatableProperty: 'vibrationLevel',
                ![@Common.Label]: 'Average Vibration'
            }
        ]
    }
);
