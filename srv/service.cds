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
  user_ID, // 👈 make sure this is explicitly listed
  user   // 👈 association for dropdown label (via @Common.Text)
}


@cds.redirection.target
  @odata.draft.enabled
  entity DepreciationRecords as projection on db.DepreciationRecords;

 @odata.draft.enabled
entity FailurePredictions as projection on db.FailurePredictions {
  analysisDate,
  failureProbability,
  algorithmUsed,
  asset,
  asset_ID,
   // 👈 explicitly include the foreign key
};
annotate jouleSrv.FailurePredictions with {
  asset @Common.Text: asset.name;
};

@odata.draft.enabled
 entity Users as projection on db.Users {
  ID,
  fullName,
  maintenanceTasks
};

}
 
 @odata.draft.enabled
  @cds.redirection.target
  entity AssetMetricsAnalyticsSet as projection on db.AssetMetricsAnalytics;

annotate jouleSrv.MaintenanceTasks with @UI.FieldGroup #GeneralDetails : {
  Data : [
    { Value: scheduledDate },
    { Value: completedDate },
    { Value: status },
    { Value: technicianNotes },
    { Value: user_ID } // 👈 ensures user dropdown shows
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


