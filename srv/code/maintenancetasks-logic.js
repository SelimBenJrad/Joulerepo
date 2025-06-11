/**
 * 
 * @On(event = { "CREATE", "UPDATE" }, entity = "jouleSrv.MaintenanceTasks")
 * @param {cds.Request} request - User information, tenant-specific CDS model, headers and query parameters
 * @param {Function} next - Callback function to the next handler
 */
module.exports = async function(request, next) {

    // Extract data from the request
    const data = request.data;

    // Check if the asset exists
    if (data.asset_ID) {
        const { Assets } = cds.entities;
        const asset = await SELECT.one.from(Assets).where({ ID: data.asset_ID });

        if (!asset) {
            return request.error(404, `Asset with ID ${data.asset_ID} not found.`);
        }
    }

    // Perform additional logic if needed, e.g., validation or transformation

    // Proceed to the next handler
    return next();
}