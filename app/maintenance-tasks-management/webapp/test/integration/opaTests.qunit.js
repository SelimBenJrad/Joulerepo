sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'maintenancetasksmanagement/test/integration/FirstJourney',
		'maintenancetasksmanagement/test/integration/pages/MaintenanceTasksList',
		'maintenancetasksmanagement/test/integration/pages/MaintenanceTasksObjectPage'
    ],
    function(JourneyRunner, opaJourney, MaintenanceTasksList, MaintenanceTasksObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('maintenancetasksmanagement') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheMaintenanceTasksList: MaintenanceTasksList,
					onTheMaintenanceTasksObjectPage: MaintenanceTasksObjectPage
                }
            },
            opaJourney.run
        );
    }
);