using jouleSrv as service from '../../srv/service';
annotate service.AssetMetrics with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'recordedAt',
                Value : recordedAt,
            },
            {
                $Type : 'UI.DataField',
                Label : 'operatingHours',
                Value : operatingHours,
            },
            {
                $Type : 'UI.DataField',
                Label : 'temperature',
                Value : temperature,
            },
            {
                $Type : 'UI.DataField',
                Label : 'vibrationLevel',
                Value : vibrationLevel,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PredictedFailure',
                Value : PredictedFailure,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PredictionConfidence',
                Value : PredictionConfidence,
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
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'recordedAt',
            Value : recordedAt,
        },
        {
            $Type : 'UI.DataField',
            Label : 'operatingHours',
            Value : operatingHours,
        },
        {
            $Type : 'UI.DataField',
            Label : 'temperature',
            Value : temperature,
            Criticality : #Critical,
            CriticalityRepresentation : #WithIcon,
        },
        {
            $Type : 'UI.DataField',
            Label : 'vibrationLevel',
            Value : vibrationLevel,
        },
        {
            $Type : 'UI.DataField',
            Label : 'PredictedFailure',
            Value : PredictedFailure,
        },
    ],
);

annotate service.AssetMetrics with {
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
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'purchaseValue',
            },
        ],
    }
};

