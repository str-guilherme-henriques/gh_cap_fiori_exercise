sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'innova.tech.front.frontendprojects',
            componentId: 'WorkEntriesObjectPage',
            contextPath: '/Projects/workEntries'
        },
        CustomPageDefinitions
    );
});