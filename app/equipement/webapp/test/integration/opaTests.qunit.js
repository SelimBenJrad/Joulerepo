sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'equipement/test/integration/FirstJourney',
		'equipement/test/integration/pages/EquipmentList',
		'equipement/test/integration/pages/EquipmentObjectPage'
    ],
    function(JourneyRunner, opaJourney, EquipmentList, EquipmentObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('equipement') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheEquipmentList: EquipmentList,
					onTheEquipmentObjectPage: EquipmentObjectPage
                }
            },
            opaJourney.run
        );
    }
);