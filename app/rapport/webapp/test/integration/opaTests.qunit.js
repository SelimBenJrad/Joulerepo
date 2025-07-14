sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'rapport/rapport/test/integration/FirstJourney',
		'rapport/rapport/test/integration/pages/RapportList',
		'rapport/rapport/test/integration/pages/RapportObjectPage'
    ],
    function(JourneyRunner, opaJourney, RapportList, RapportObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('rapport/rapport') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheRapportList: RapportList,
					onTheRapportObjectPage: RapportObjectPage
                }
            },
            opaJourney.run
        );
    }
);