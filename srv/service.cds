using { Joule as db } from '../db/schema';

service jouleSrv {

  @odata.draft.enabled
  @cds.redirection.target
  entity Assets as projection on db.Assets;

  
  @odata.draft.enabled
  @cds.redirection.target
  entity MaintenanceTasks as projection on db.MaintenanceTasks {
  *,
  user // 👈 this exposes the associated user in the OData service
}

  @odata.draft.enabled
  entity DepreciationRecords as projection on db.DepreciationRecords;

  @odata.draft.enabled
  entity FailurePredictions as projection on db.FailurePredictions;

@odata.draft.enabled
 entity Users as projection on db.Users {
  *,
  maintenanceTasks
};

}

annotate jouleSrv.MaintenanceTasks with {
  @UI.ReferenceFacet: {
    label: 'Assigned User',
    target: '@UI.FieldGroup#UserDetails'
  }
  user @UI.FieldGroup#UserDetails: {
    fullName,
    email,
    role,
    isActive
  };
}
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
annotate jouleSrv.MaintenanceTasks with {
  user @Common.Text: user.fullName;
};
