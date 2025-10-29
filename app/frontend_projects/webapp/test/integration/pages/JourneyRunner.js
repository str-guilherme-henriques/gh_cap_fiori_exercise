sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"innova/tech/front/frontendprojects/test/integration/pages/ProjectsList",
	"innova/tech/front/frontendprojects/test/integration/pages/ProjectsObjectPage",
	"innova/tech/front/frontendprojects/test/integration/pages/WorkEntriesObjectPage"
], function (JourneyRunner, ProjectsList, ProjectsObjectPage, WorkEntriesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('innova/tech/front/frontendprojects') + '/test/flp.html#app-preview',
        pages: {
			onTheProjectsList: ProjectsList,
			onTheProjectsObjectPage: ProjectsObjectPage,
			onTheWorkEntriesObjectPage: WorkEntriesObjectPage
        },
        async: true
    });

    return runner;
});

