sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'assetmanagement/asset/test/integration/FirstJourney',
		'assetmanagement/asset/test/integration/pages/AssetsList',
		'assetmanagement/asset/test/integration/pages/AssetsObjectPage',
		'assetmanagement/asset/test/integration/pages/MaintenanceTasksObjectPage'
    ],
    function(JourneyRunner, opaJourney, AssetsList, AssetsObjectPage, MaintenanceTasksObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('assetmanagement/asset') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheAssetsList: AssetsList,
					onTheAssetsObjectPage: AssetsObjectPage,
					onTheMaintenanceTasksObjectPage: MaintenanceTasksObjectPage
                }
            },
            opaJourney.run
        );
    }
);