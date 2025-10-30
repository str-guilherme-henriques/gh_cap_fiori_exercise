namespace innova.tech;

using { managed,cuid } from '@sap/cds/common';

entity Employee : cuid, managed {
    name        : String(100)           @title : '{i18n>EmployeeName}'  @mandatory;
    email       : String(100)           @title : '{i18n>email}'         @mandatory;
    workEntries : Association to many WorkEntry on workEntries.employee = $self @readonly;
    isActive    : Boolean default true  @title : '{i18n>isActive}';
}

entity Project : cuid, managed {
    name        : String(100)               @title : '{i18n>ProjectName}' @mandatory;
    client      : String(100)               @title : '{i18n>client}'      @mandatory;
    workEntries : Association to many WorkEntry on workEntries.project = $self @readonly;
    isActive    : Boolean default true      @title : '{i18n>isActive}';
}

entity WorkEntry : cuid, managed {
    date        : Date                      @title : '{i18n>date}'      @mandatory;
    hours       : Decimal(4,1)              @title : '{i18n>hours}'     @mandatory;
    employee    : Association to Employee   @title : '{i18n>Employee}'  @mandatory;
    project     : Association to Project    @title : '{i18n>Project}';
    isActive    : Boolean default true      @title : '{i18n>isActive}';
}