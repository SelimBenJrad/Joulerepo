const test_assets_logic = require('./code/test-assets-logic');
const cds = require('@sap/cds/lib');
const {
  GET,
  POST,
  PATCH,
  DELETE,
  expect
} = cds.test(__dirname + '../../', '--with-mocks');
cds.env.requires.auth = {
  kind: "dummy"
};
describe('Service Testing', () => {
  it('test assets-logic', async () => {
    await test_assets_logic(GET, POST, PATCH, DELETE, expect);
  });
});