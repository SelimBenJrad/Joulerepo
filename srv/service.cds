using { Joule as db } from '../db/schema';
service jouleSrv {

  @odata.draft.enabled
  @cds.redirection.target
  entity Assets as projection on db.Assets;

  @odata.draft.enabled
  @cds.redirection.target
  entity AssetMetrics as projection on db.AssetMetrics;
  @odata.draft.enabled
  @cds.redirection.target
 entity MaintenanceTasks as projection on db.MaintenanceTasks {
  *,
  emailAddress,
}


@cds.redirection.target
  @odata.draft.enabled
  entity DepreciationRecords as projection on db.DepreciationRecords;

 @odata.draft.enabled
entity FailurePredictions as projection on db.FailurePredictions {
  *,  // Include all fields, including ID
  analysisDate,
  failureProbability,
  algorithmUsed,
  asset,
  asset_ID
};
annotate jouleSrv.FailurePredictions with {
  asset @Common.Text: asset.name;
};

@odata.draft.enabled
 entity Users as projection on db.Users {
  *,  // Include all fields
  maintenanceTasks: Association to many MaintenanceTasks
};

@cds.redirection.target
@Analytics.AggregatedProperties: [
  { Property: 'operatingHours', AggregationMethod: 'sum' },
  { Property: 'temperature', AggregationMethod: 'avg' },
  { Property: 'vibrationLevel', AggregationMethod: 'avg' },
  { Property: 'PredictionConfidence', AggregationMethod: 'avg' }
]
entity AssetMetricsAnalyticsSet as projection on db.AssetMetricsAnalytics;
}
    { Property: 'operatingHours', AggregationMethod: 'sum' },
    { Property: 'temperature', AggregationMethod: 'avg' },
    { Property: 'vibrationLevel', AggregationMethod: 'avg' },
    { Property: 'PredictionConfidence', AggregationMethod: 'avg' }
  ]
  entity AssetMetricsAnalyticsSet as projection on db.AssetMetricsAnalytics;

annotate jouleSrv.MaintenanceTasks with @UI.FieldGroup #GeneralDetails : {
  Data : [
    { Value: scheduledDate },
    { Value: completedDate },
    { Value: status },
    { Value: technicianNotes }
  ]
};


annotate jouleSrv.MaintenanceTasks with @UI.Facets : [
  {
    $Type: 'UI.ReferenceFacet',
    Label: 'General Information',
    Target: '@UI.FieldGroup#GeneralDetails'
  }
];

annotate Joule.MaintenanceTasks with {
  asset @Common.Text: asset.name;
};
annotate jouleSrv.Users with {
  @UI.ReferenceFacet: {
    label: 'Maintenance Tasks',
    target: '@UI.FieldGroup#TaskDetails'
  }
  maintenanceTasks @UI.FieldGroup#TaskDetails: {
    taskName,
    dueDate,
    status
  };
}


