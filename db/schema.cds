namespace Joule;
using { cuid, managed } from '@sap/cds/common';

@assert.unique: { assetId: [assetId] }
entity Assets : cuid, managed {
  assetId: String(36) @mandatory;
  name: String(100);
  type: String(50);
  purchaseDate: Date;
  purchaseValue: Integer;
  depreciationMethod: String(50);
  expectedLifetime: Integer;
  maintenanceTasks: Association to many MaintenanceTasks on maintenanceTasks.asset = $self;
  depreciationRecords: Association to many DepreciationRecords on depreciationRecords.asset = $self;
  failurePredictions: Association to many FailurePredictions on failurePredictions.asset = $self;
}

@assert.unique: { taskId: [taskId] }
entity MaintenanceTasks : cuid, managed {
  taskId: String(36) @mandatory;
  scheduledDate: Date;
  completedDate: Date;
  status: String(20);
  technicianNotes: String(500);
  asset: Association to Assets;
}

@assert.unique: { recordId: [recordId] }
entity DepreciationRecords : cuid, managed {
  recordId: String(36) @mandatory;
  periodStart: Date;
  periodEnd: Date;
  depreciationAmount: Integer;
  asset: Association to Assets;
}

@assert.unique: { predictionId: [predictionId] }
entity FailurePredictions : cuid, managed {
  predictionId: String(36) @mandatory;
  analysisDate: Date;
  failureProbability: Decimal(5,2);
  algorithmUsed: String(100);
  asset: Association to Assets;
}
