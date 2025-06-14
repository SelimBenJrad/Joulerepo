namespace Joule;

using {
    managed
} from '@sap/cds/common';

entity Assets : managed {
    key assetId : String(36) @mandatory;
    name : String(100);
    type : String(50);
    purchaseDate : Date;
    purchaseValue : Integer;
    depreciationMethod : String(50);
    expectedLifetime : Integer;
    maintenanceTasks    : Association to many MaintenanceTasks on maintenanceTasks.asset_ID = $self.assetId;
    depreciationRecords : Association to many DepreciationRecords on depreciationRecords.asset_ID = $self.assetId;
    failurePredictions  : Association to many FailurePredictions on failurePredictions.asset_ID = $self.assetId;
}

annotate Assets with @assert.unique : {
    assetId : [ assetId ],
};

entity MaintenanceTasks : managed {
    key taskId           : Integer @mandatory;
    scheduledDate    : Date;
    completedDate    : Date;
    status           : String(20);
    technicianNotes  : String(500);
    
    asset_ID         : String(36); // Changed to match Assets.assetId type
    asset            : Association to one Assets on asset_ID = asset.assetId;
    
    user_ID          : UUID;
    user             : Association to one Users on user_ID = user.ID;
}

annotate MaintenanceTasks with @assert.unique : {
    taskId : [ taskId ],
};

entity DepreciationRecords : managed {
    key recordId           : String(36) @mandatory;
    periodStart        : Date;
    periodEnd          : Date;
    depreciationAmount : Integer;
    
    asset_ID           : String(36); // Changed to match Assets.assetId type
    asset              : Association to one Assets on asset_ID = asset.assetId;
}

annotate DepreciationRecords with @assert.unique : {
    recordId : [ recordId ],
};

entity FailurePredictions : managed {
    key predictionId       : String(36) @mandatory;
    analysisDate       : Date;
    failureProbability : Decimal(5,2);
    algorithmUsed      : String(100);
    
    asset_ID           : String(36); // Changed to match Assets.assetId type
    asset              : Association to one Assets on asset_ID = asset.assetId;
}

annotate FailurePredictions with @assert.unique : {
    predictionId : [ predictionId ],
};

type Role : String enum {
    admin;
    technician;
    viewer;
}

entity Users {
    key ID       : UUID;
    email        : String;
    fullName     : String;
    role         : Role;
    isActive     : Boolean default true;
    
    maintenanceTasks : Association to many MaintenanceTasks on maintenanceTasks.user_ID = $self.ID;
}