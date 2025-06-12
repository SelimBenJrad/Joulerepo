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