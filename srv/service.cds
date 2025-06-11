using { Joule as db } from '../db/schema';

service jouleSrv {
  @odata.draft.enabled
  entity Assets as projection on db.Assets;
  @odata.draft.enabled
  entity MaintenanceTasks as projection on db.MaintenanceTasks;
  @odata.draft.enabled
  entity DepreciationRecords as projection on db.DepreciationRecords;
  @odata.draft.enabled
  entity FailurePredictions as projection on db.FailurePredictions;
}
