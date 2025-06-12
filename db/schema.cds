namespace Joule;

using
{
    cuid,
    managed
}
from '@sap/cds/common';

entity Assets : cuid, managed
{
    assetId : String(36)
        @mandatory;
    name : String(100);
    type : String(50);
    purchaseDate : Date;
    purchaseValue : Integer;
    depreciationMethod : String(50);
    expectedLifetime : Integer;
    maintenanceTasks : Association to many MaintenanceTasks on maintenanceTasks.asset = $self;
    depreciationRecords : Association to many DepreciationRecords on depreciationRecords.asset = $self;
    failurePredictions : Association to many FailurePredictions on failurePredictions.asset = $self;
}

annotate Assets with @assert.unique :
{
    assetId : [ assetId ],
};

entity MaintenanceTasks : cuid, managed
{
    taskId : Integer
        @mandatory;
    scheduledDate : Date;
    completedDate : Date;
    status : String(20);
    technicianNotes : String(500);
    asset : Association to one Assets;
    user : Association to one Users;
}

annotate MaintenanceTasks with @assert.unique :
{
    taskId : [ taskId ],
};

entity DepreciationRecords : cuid, managed
{
    recordId : String(36)
        @mandatory;
    periodStart : Date;
    periodEnd : Date;
    depreciationAmount : Integer;
    asset : Association to one Assets;
}

annotate DepreciationRecords with @assert.unique :
{
    recordId : [ recordId ],
};

entity FailurePredictions : cuid, managed
{
    predictionId : String(36)
        @mandatory;
    analysisDate : Date;
    failureProbability : Decimal(5,2);
    algorithmUsed : String(100);
    asset : Association to one Assets;
}

annotate FailurePredictions with @assert.unique :
{
    predictionId : [ predictionId ],
};

type Role : String enum {
    admin;
    technician;
    viewer;
}

entity Users : cuid
{
    key ID : UUID;
    email : String;
    fullName : String;
    role : Role;
    isActive : Boolean default true;
    maintenanceTasks : Association to many MaintenanceTasks on maintenanceTasks.user = $self;
}