using jouleSrv from '../srv/service.cds';

// === ASSETS ===

annotate jouleSrv.Assets with @UI.HeaderInfo: {
  TypeName: 'Asset',
  TypeNamePlural: 'Assets',
  Title: { Value: assetId }
};

annotate jouleSrv.Assets with {
  assetId @UI.Identification @Common.Text: { $value: assetId, TextArrangement: #TextOnly };
  name @title: 'Name';
  type @title: 'Type';
  purchaseDate @title: 'Purchase Date';
  purchaseValue @title: 'Purchase Value';
  depreciationMethod @title: 'Depreciation Method';
  expectedLifetime @title: 'Expected Lifetime';
  createdAt @title: 'Created At';
  createdBy @title: 'Created By';
  modifiedAt @title: 'Modified At';
  modifiedBy @title: 'Modified By'
};

annotate jouleSrv.Assets with @UI.LineItem: [
  { Value: assetId },
  { Value: name },
  { Value: type },
  { Value: purchaseDate },
  { Value: purchaseValue },
  { Value: depreciationMethod },
  { Value: expectedLifetime }
];

annotate jouleSrv.Assets with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType',
  Data: [
    { Value: assetId },
    { Value: name },
    { Value: type },
    { Value: purchaseDate },
    { Value: purchaseValue },
    { Value: depreciationMethod },
    { Value: expectedLifetime },
    { Value: createdAt },
    { Value: createdBy },
    { Value: modifiedAt },
    { Value: modifiedBy }
  ]
};

annotate jouleSrv.Assets with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' },
  { $Type: 'UI.ReferenceFacet', Label: 'Maintenance Tasks', Target: 'maintenanceTasks/@UI.LineItem' },
  { $Type: 'UI.ReferenceFacet', Label: 'Depreciation Records', Target: 'depreciationRecords/@UI.LineItem' },
  { $Type: 'UI.ReferenceFacet', Label: 'Failure Predictions', Target: 'failurePredictions/@UI.LineItem' }
];

annotate jouleSrv.Assets with @UI.SelectionFields: [
  assetId, name, type
];

// === MAINTENANCE TASKS ===

annotate jouleSrv.MaintenanceTasks with @UI.HeaderInfo: {
  TypeName: 'Maintenance Task',
  TypeNamePlural: 'Maintenance Tasks',
  Title: { Value: taskId }
};

annotate jouleSrv.MaintenanceTasks with {
  taskId @UI.Identification @Common.Text: { $value: taskId, TextArrangement: #TextOnly };
  scheduledDate @title: 'Scheduled Date';
  completedDate @title: 'Completed Date';
  status @title: 'Status';
  technicianNotes @title: 'Technician Notes';
  asset @Common.Text: { $value: asset.assetId, TextArrangement: #TextOnly };
  asset @Common.Label: 'Asset';
};

annotate jouleSrv.MaintenanceTasks with @UI.LineItem: [
  { Value: taskId },
  { Value: scheduledDate },
  { Value: completedDate },
  { Value: status },
  { Value: technicianNotes },
  { Label: 'Asset Name', Value: asset.name },
  { Label: 'User', Value: user.fullName }
];

annotate jouleSrv.MaintenanceTasks with @UI.SelectionFields: [
  taskId, asset_ID
];

// === DEPRECIATION RECORDS ===

annotate jouleSrv.DepreciationRecords with @UI.HeaderInfo: {
  TypeName: 'Depreciation Record',
  TypeNamePlural: 'Depreciation Records',
  Title: { Value: recordId }
};

annotate jouleSrv.DepreciationRecords with {
  recordId @UI.Identification @Common.Text: { $value: recordId, TextArrangement: #TextOnly };
  periodStart @title: 'Period Start';
  periodEnd @title: 'Period End';
  depreciationAmount @title: 'Depreciation Amount';
  asset @Common.Text: { $value: asset.assetId, TextArrangement: #TextOnly };
  asset @Common.Label: 'Asset';
};

annotate jouleSrv.DepreciationRecords with @UI.LineItem: [
  { Value: recordId },
  { Value: periodStart },
  { Value: periodEnd },
  { Value: depreciationAmount },
  { Label: 'Asset Name', Value: asset.name }
];

annotate jouleSrv.DepreciationRecords with @UI.SelectionFields: [
  recordId, asset_ID
];

// === FAILURE PREDICTIONS ===

annotate jouleSrv.FailurePredictions with @UI.HeaderInfo: {
  TypeName: 'Failure Prediction',
  TypeNamePlural: 'Failure Predictions',
  Title: { Value: predictionId }
};

annotate jouleSrv.FailurePredictions with {
  predictionId @UI.Identification @Common.Text: { $value: predictionId, TextArrangement: #TextOnly };
  analysisDate @title: 'Analysis Date';
  failureProbability @title: 'Failure Probability';
  algorithmUsed @title: 'Algorithm Used';
  asset @Common.Text: { $value: asset.assetId, TextArrangement: #TextOnly };
  asset @Common.Label: 'Asset';
};

annotate jouleSrv.FailurePredictions with @UI.LineItem: [
  { Value: predictionId },
  { Value: analysisDate },
  { Value: failureProbability },
  { Value: algorithmUsed },
  { Label: 'Asset Name', Value: asset.name }
];

annotate jouleSrv.FailurePredictions with @UI.SelectionFields: [
  predictionId, asset_ID
];

annotate jouleSrv.MaintenanceTasks with {
  user @Common.Text: { $value: user.fullName };
};

