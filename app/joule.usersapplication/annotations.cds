using jouleSrv as service from '../../srv/service';
annotate service.Users with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'email',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Label : 'fullName',
                Value : fullName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'role',
                Value : role,
            },
            {
                $Type : 'UI.DataField',
                Label : 'isActive',
                Value : isActive,
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
        {
  $Type: 'UI.ReferenceFacet',
  ID: 'UserTasks',
  Label: 'Maintenance Tasks',
  Target: 'maintenanceTasks/@UI.LineItem'
},
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'email',
            Value : email,
        },
        {
            $Type : 'UI.DataField',
            Label : 'fullName',
            Value : fullName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'role',
            Value : role,
        },
        {
            $Type : 'UI.DataField',
            Label : 'isActive',
            Value : isActive,
        },
    ],
);

