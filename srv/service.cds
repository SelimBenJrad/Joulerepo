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
  *,  
  // Include all fields
  };

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

  @odata.draft.enabled
  @cds.redirection.target
  entity Equipment as projection on db.Equipment;

annotate jouleSrv.Equipment with @UI.HeaderInfo: {
  TypeName: 'Equipment',
  TypeNamePlural: 'Equipment',
  Title: { Value: id }
};

annotate jouleSrv.Equipment with {
  id @UI.Identification @Common.Text: { $value: id, TextArrangement: #TextOnly };
  type @title: 'Type';
  usageHours @title: 'Usage Hours';
  ageYears @title: 'Age (Years)';
  maintenanceCount @title: 'Maintenance Count';
};

annotate jouleSrv.Equipment with @UI.LineItem: [
  { Value: id },
  { Value: type },
  { Value: usageHours },
  { Value: ageYears },
  { Value: maintenanceCount }
];

annotate jouleSrv.Equipment with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType',
  Data: [
    { Value: id },
    { Value: type },
    { Value: usageHours },
    { Value: ageYears },
    { Value: maintenanceCount }
  ]
};

annotate jouleSrv.Equipment with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate jouleSrv.Equipment with @UI.SelectionFields: [
  id, type, ageYears
];

}