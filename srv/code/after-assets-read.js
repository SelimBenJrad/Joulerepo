/**
 * The custom logic attached to the Assets entity to calculate straight-line depreciation after a READ event, ensuring that the data source remains unchanged while performing necessary computations.
  @On(event = { "CREATE","UPDATE" }, entity = "jouleSrv.Assets")
 
* @param {cds.Request} request - User information, tenant-specific CDS model, headers and query parameters
 * @param {Function} next - Callback function to the next handler
*/

module.exports = async function(request, next) {
    if (!results) return;

    // Ensure results is an array
    if (!Array.isArray(results)) {
        results = [results];
    }

    // Calculate straight-line depreciation for each asset
    results.forEach(asset => {
        if (asset.purchaseValue !== undefined && asset.expectedLifetime !== undefined && asset.expectedLifetime > 0) {
            const currentDate = new Date();
            const purchaseDate = new Date(asset.purchaseDate);
            const yearsElapsed = (currentDate - purchaseDate) / (1000 * 60 * 60 * 24 * 365.25);

            // Calculate depreciation per year
            const annualDepreciation = asset.purchaseValue / asset.expectedLifetime;

            // Calculate accumulated depreciation
            const accumulatedDepreciation = Math.min(annualDepreciation * yearsElapsed, asset.purchaseValue);

            // Add calculated depreciation to the asset object
            asset.accumulatedDepreciation = Math.round(accumulatedDepreciation);
        } else {
            asset.accumulatedDepreciation = 0;
        }
    });
}
