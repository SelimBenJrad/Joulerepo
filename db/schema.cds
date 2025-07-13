namespace Joule;

using {cuid,
    managed
} from '@sap/cds/common';

entity Assets : cuid,managed {
    name : String(100);
    type : String(50);
    purchaseDate : Date;
    purchaseValue : Integer;
    depreciationMethod : String(50);
    expectedLifetime : Integer;
    // Predictive features
    operatingHours        : Integer;        // Useful for failure prediction
    lastMaintenanceDate   : Date;
    lastFailureDate       : Date;

    maintenanceTasks    : Association to many MaintenanceTasks on maintenanceTasks.asset_ID = $self.ID;
    depreciationRecords : Association to many DepreciationRecords on depreciationRecords.asset_ID = $self.ID;
    failurePredictions  : Association to many FailurePredictions on failurePredictions.asset_ID = $self.ID;
}


entity MaintenanceTasks : cuid,managed {
    scheduledDate    : Date;
    completedDate    : Date;
    status           : String(20);
    technicianNotes  : String(500);
    emailAddress     : String(100);

    asset_ID         : String(36); // Changed to match Assets.assetId type
    asset            : Association to one Assets on asset_ID = asset.ID;
}


entity DepreciationRecords : cuid,managed {
    periodStart        : Date;
    periodEnd          : Date;
    depreciationAmount : Integer;
    
    asset_ID           : UUID; // Changed to match Assets.assetId type
    asset              : Association to one Assets on asset_ID = asset.ID;
}


entity FailurePredictions : cuid,managed {
    analysisDate       : Date;
    failureProbability : Decimal(5,2);
    algorithmUsed      : String(100);
    
    asset_ID           : UUID; // Changed to match Assets.assetId type
    asset              : Association to one Assets on asset_ID = asset.ID;
}

type Role : String enum {
    admin;
    technician;
    viewer;
}

entity Users:cuid {
    email        : String;
    fullName     : String;
    role         : Role;
    isActive     : Boolean default true;
    
}
// === ASSET METRICS (for time-series tracking) ===
entity AssetMetrics : cuid, managed {
    recordedAt       : DateTime;
    operatingHours   : Integer;
    temperature      : Decimal(5,2);
    vibrationLevel   : Decimal(5,2);

    PredictedFailure     : String(3);       // "YES"/"NO" → true/false
    PredictionConfidence : Decimal(10,8); // e.g. 0.11538883

    asset_ID         : String(36);
    asset            : Association to one Assets on asset_ID = asset.ID;
}

// New Equipment Entity
entity Equipment : managed {
    id                  : UUID;
    type                 : String(50);              // e.g. "Laptop", "Machine", "Vehicle"
    usageHours          : Integer;       // e.g. 1200
    ageYears            : Integer;         // e.g. 5
    maintenanceCount    : Integer; // e.g. 3
}

// ————————————
// === Analytical Aggregate View ===


view AssetMetricsAnalytics as
  select from AssetMetrics {
    key asset_ID                          @Analytics.Dimension @(Aggregation.ContextDefiningProperties: []),
    asset.name                            as assetName @Analytics.Dimension,
    @Analytics.Dimension
    @(Aggregation.group: true)
    cast(year(recordedAt)  as Integer)    as recordedYear,
    @Analytics.Dimension
    @(Aggregation.group: true)
    cast(month(recordedAt) as Integer)    as recordedMonth,
    // Measures
    @Analytics.Measure
    @Aggregation.default: #SUM
    operatingHours,
    @Analytics.Measure
    @Aggregation.default: #AVG
    temperature,
    @Analytics.Measure
    @Aggregation.default: #AVG
    vibrationLevel,
    @Analytics.Measure
    @Aggregation.default: #AVG
    PredictionConfidence
}