using TimesheetService from './timesheet-service';

//== Annotations for Employees

annotate TimesheetService.Employees with @(
    UI: {
        HeaderInfo: {
            TypeName: '{i18n>Employee}',
            TypeNamePlural: '{i18n>Employees}',
            Title: { Value: name },
            Description: { Value: email }
        },
        LineItem: [
            { Value: name },
            { Value: email },
            {
                $Type : 'UI.DataFieldForAction',
                Label : '{i18n>getWeeklyHoursSummary}',
                Action : 'TimesheetService.getWeeklyHoursSummary'
            }
        ],
        Facets: [
            {
                $Type: 'UI.ReferenceFacet',
                Label: '{i18n>GeneralInformation}',
                Target: '@UI.FieldGroup#General'
            },
            {
                $Type: 'UI.ReferenceFacet',
                Label: '{i18n>WorkEntries}',
                Target: 'workEntries/@UI.LineItem#WE'
            }
        ],
        FieldGroup #General: { Data: [
            { Value: name },
            { Value: email }
        ] }
    }
);

annotate TimesheetService.Employees with {
    ID @UI.Hidden;
    name @Common.Label: '{i18n>EmployeeName}';
};

annotate TimesheetService.Employees with @(
    Capabilities.NavigationRestrictions: {
        RestrictedProperties: [{
            NavigationProperty: workEntries,
            InsertRestrictions: { Insertable: false },
            UpdateRestrictions: { Updatable: false },
            DeleteRestrictions: { Deletable: false }
        }]
    }
);

//== Annotations for Projects

annotate TimesheetService.Projects with @(
    UI: {
        HeaderInfo: {
            TypeName: '{i18n>Project}',
            TypeNamePlural: '{i18n>Projects}',
            Title: { Value: name },
            Description: { Value: client }
        },
        LineItem #Projects: [
            { Value: name },
            { Value: client },
            {
                $Type : 'UI.DataFieldForAction',
                Label : '{i18n>getWeeklyHoursSummary}',
                Action : 'TimesheetService.getWeeklyHoursSummary'
            },
            {
                $Type : 'UI.DataFieldForAction',
                Label : '{i18n>getProjectEffort}',
                Action : 'TimesheetService.getProjectEffort'
            }
        ],
        //== Initial Load Alternative
        PresentationVariant: {
            SortOrder: [{
                Property: name,
                Descending: false
            }],
            Visualizations: ['@UI.LineItem#Projects'],
            InitialExpansionLevel: 1
        },
        //== End
        Facets: [
            {
                $Type: 'UI.ReferenceFacet',
                Label: '{i18n>GeneralInformation}',
                Target: '@UI.FieldGroup#General'
            },
            {
                $Type: 'UI.ReferenceFacet',
                Label: '{i18n>WorkEntries}',
                Target: 'workEntries/@UI.LineItem#WE'
            }
        ],
        FieldGroup #General: { Data: [
            { Value: name },
            { Value: client }
        ] }
    }
);

annotate TimesheetService.Projects with {
    ID @UI.Hidden;
    name @Common.Label: '{i18n>ProjectName}';
};

annotate TimesheetService.Projects with @(
    Capabilities.NavigationRestrictions: {
        RestrictedProperties: [{
            NavigationProperty: workEntries,
            InsertRestrictions: { Insertable: false },
            UpdateRestrictions: { Updatable: false },
            DeleteRestrictions: { Deletable: false }
        }]
    }
);

annotate TimesheetService.WorkEntries with @(
    UI: {
        HeaderInfo: {
            TypeName: '{i18n>WorkEntry}',
            TypeNamePlural: '{i18n>WorkEntries}'
        },
        LineItem#WE: [
            { Value: date },
            { Value: hours }
        ],
        SelectionFields: [
            employee_ID,
            project_ID
        ],
    }
);

annotate TimesheetService.WorkEntries with {
    ID @UI.Hidden;
};
