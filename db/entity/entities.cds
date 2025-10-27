namespace innova.tech;

using { innova.tech as asp} from '../aspects/aspects.cds';

entity Employee : asp.Identifiable {
    name        : String(100);
    email       : String(100);
    workEntries : Association to many WorkEntry on workEntries.employee = $self;
    isActive    : Boolean default true;
}

entity Project : asp.Identifiable {
    name        : String(100);
    client      : String(100);
    workEntries : Association to many WorkEntry on workEntries.project = $self;
    isActive    : Boolean default true;
}

entity WorkEntry : asp.Identifiable {
    date        : Date;
    hours       : Decimal(4,1);
    employee    : Association to Employee;
    project     : Association to Project;
    isActive    : Boolean default true;
}