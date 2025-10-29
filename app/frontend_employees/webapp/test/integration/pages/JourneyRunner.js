sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"innova/tech/front/frontendemployees/test/integration/pages/EmployeesList",
	"innova/tech/front/frontendemployees/test/integration/pages/EmployeesObjectPage",
	"innova/tech/front/frontendemployees/test/integration/pages/WorkEntriesObjectPage"
], function (JourneyRunner, EmployeesList, EmployeesObjectPage, WorkEntriesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('innova/tech/front/frontendemployees') + '/test/flpSandbox.html#innovatechfrontfrontendemploye-tile',
        pages: {
			onTheEmployeesList: EmployeesList,
			onTheEmployeesObjectPage: EmployeesObjectPage,
			onTheWorkEntriesObjectPage: WorkEntriesObjectPage
        },
        async: true
    });

    return runner;
});

