using jouleSrv as service from '../../srv/service';
using from '../annotations';

annotate service.MaintenanceTasks with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'taskId',
                Value : taskId,
            },
            {
                $Type : 'UI.DataField',
                Value : scheduledDate,
            },
            {
                $Type : 'UI.DataField',
                Value : completedDate,
            },
            {
                $Type : 'UI.DataField',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Value : technicianNotes,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Email Address',
                Value : emailAddress
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
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View',
    },
);

annotate service.MaintenanceTasks with {
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

annotate service.Users with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType',
  Data: [
    { Value: fullName },
    { Value: email },
    { Value: role },
    { Value: isActive }
  ]
};

