sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'predective/test/integration/FirstJourney',
		'predective/test/integration/pages/AssetMetricsList',
		'predective/test/integration/pages/AssetMetricsObjectPage'
    ],
    function(JourneyRunner, opaJourney, AssetMetricsList, AssetMetricsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('predective') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheAssetMetricsList: AssetMetricsList,
					onTheAssetMetricsObjectPage: AssetMetricsObjectPage
                }
            },
            opaJourney.run
        );
    }
);