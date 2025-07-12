const cds = require('@sap/cds');
const basicAuth = require('express-basic-auth');

cds.on('bootstrap', (app) => {
  // Show browser popup
  app.use(
    basicAuth({
      users: { selim: 'mypassword', admin: 'admin123' }, // Define users here
      challenge: true, // This enables the popup
      realm: 'CAP Dev Login'
    })
  );

  // Inject user into req.user for CAP role handling
  app.use((req, res, next) => {
    if (req.auth) {
      req.user = {
        id: req.auth.user,
        roles: ['Viewer'], // mock CAP roles here
      };
    }
    next();
  });
});

module.exports = cds.server;
