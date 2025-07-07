using jouleSrv as service from '../../srv/service';
annotate service.FailurePredictions with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'predictionId',
                Value : predictionId,
            },
            {
                $Type : 'UI.DataField',
                Value : analysisDate,
            },
            {
                $Type : 'UI.DataField',
                Value : failureProbability,
            },
            {
                $Type : 'UI.DataField',
                Value : algorithmUsed,
            },
            {
                $Type : 'UI.DataField',
                Label : 'asset_ID',
                Value : asset_ID,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ]
);

annotate service.FailurePredictions with {
    asset @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Assets',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : asset_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'assetId',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'type',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'purchaseDate',
            },
        ],
    }
};

