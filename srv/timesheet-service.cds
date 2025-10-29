using { innova.tech as db } from '../db/entity/entities';

service TimesheetService {
  @odata.draft.enabled
  entity Employees   as projection on db.Employee {
    *,
  } actions {
    action getWeeklyHoursSummary() returns String;
  };
  @odata.draft.enabled
  entity Projects    as projection on db.Project;
  @odata.draft.enabled
  entity WorkEntries as projection on db.WorkEntry;
}