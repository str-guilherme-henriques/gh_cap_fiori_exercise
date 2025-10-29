sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"innova/tech/front/frontendworkentries/test/integration/pages/WorkEntriesList",
	"innova/tech/front/frontendworkentries/test/integration/pages/WorkEntriesObjectPage"
], function (JourneyRunner, WorkEntriesList, WorkEntriesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('innova/tech/front/frontendworkentries') + '/test/flpSandbox.html#innovatechfrontfrontendworkent-tile',
        pages: {
			onTheWorkEntriesList: WorkEntriesList,
			onTheWorkEntriesObjectPage: WorkEntriesObjectPage
        },
        async: true
    });

    return runner;
});

