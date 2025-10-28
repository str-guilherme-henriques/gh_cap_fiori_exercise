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
                Target: 'workEntries/@UI.LineItem#WorkEntry'
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
            { Value: client }
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
                Target: 'workEntries/@UI.LineItem#WorkEntry'
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

//== Annotations for WorkEntries

annotate TimesheetService.WorkEntries with {
    ID @UI.Hidden;
    employee @Common.Text: employee.name;
    project @Common.Text: project.name;
};

annotate TimesheetService.WorkEntries with @(
    UI.LineItem #WorkEntry: [
        { Value: date },
        { Value: hours }
    ]
);
