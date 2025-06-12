sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'joule/usersapplication/test/integration/FirstJourney',
		'joule/usersapplication/test/integration/pages/UsersList',
		'joule/usersapplication/test/integration/pages/UsersObjectPage'
    ],
    function(JourneyRunner, opaJourney, UsersList, UsersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('joule/usersapplication') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheUsersList: UsersList,
					onTheUsersObjectPage: UsersObjectPage
                }
            },
            opaJourney.run
        );
    }
);