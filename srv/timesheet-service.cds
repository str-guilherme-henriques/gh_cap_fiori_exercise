using { innova.tech as db } from '../db/entity/entities';

service TimesheetService {
  @odata.draft.enabled
  entity Employees   as projection on db.Employee;
  @odata.draft.enabled
  entity Projects    as projection on db.Project;
  @odata.draft.enabled
  entity WorkEntries as projection on db.WorkEntry;

  action getWeeklySummary(employee_ID: String(4), weekStart: Date, weekEnd: Date)
      returns array of {
        project_ID: String(4);
        total: Decimal(5,1);
      };
}