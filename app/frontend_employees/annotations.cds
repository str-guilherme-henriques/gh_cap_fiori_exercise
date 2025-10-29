using TimesheetService as service from '../../srv/timesheet-service';
annotate service.WorkEntries with {
    project @Common.ExternalID : project.name
};

annotate service.WorkEntries with {
    employee @Common.ExternalID : employee.name
};

