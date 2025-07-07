sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'failure/test/integration/FirstJourney',
		'failure/test/integration/pages/FailurePredictionsList',
		'failure/test/integration/pages/FailurePredictionsObjectPage'
    ],
    function(JourneyRunner, opaJourney, FailurePredictionsList, FailurePredictionsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('failure') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheFailurePredictionsList: FailurePredictionsList,
					onTheFailurePredictionsObjectPage: FailurePredictionsObjectPage
                }
            },
            opaJourney.run
        );
    }
);