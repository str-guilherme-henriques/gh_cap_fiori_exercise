using { innova.tech as db } from '../db/entity/entities';

service TimesheetService {
  entity Employees   as projection on db.Employee;
  entity Projects    as projection on db.Project;
  entity WorkEntries as projection on db.WorkEntry;

  action getWeeklySummary(employee_ID: UUID, weekStart: Date, weekEnd: Date)
      returns array of {
        project_ID: UUID;
        total: Decimal(5,1);
      };
}