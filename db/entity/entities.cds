namespace innova.tech;

using { innova.tech as asp} from '../aspects/aspects.cds';
using { managed } from '@sap/cds/common';

entity Employee : asp.Identifiable, managed {
    name        : String(100)           @title : '{i18n>EmployeeName}';
    email       : String(100)           @title : '{i18n>email}';
    workEntries : Association to many WorkEntry on workEntries.employee = $self;
    isActive    : Boolean default true  @title : '{i18n>isActive}';
}

entity Project : asp.Identifiable, managed {
    name        : String(100)               @title : '{i18n>ProjectName}';
    client      : String(100)               @title : '{i18n>client}';
    workEntries : Association to many WorkEntry on workEntries.project = $self;
    isActive    : Boolean default true      @title : '{i18n>isActive}';
}

entity WorkEntry : asp.Identifiable, managed {
    date        : Date                      @title : '{i18n>date}';
    hours       : Decimal(4,1)              @title : '{i18n>hours}';
    employee    : Association to Employee   @title : '{i18n>Employee}';
    project     : Association to Project    @title : '{i18n>Project}';
    isActive    : Boolean default true      @title : '{i18n>isActive}';
}