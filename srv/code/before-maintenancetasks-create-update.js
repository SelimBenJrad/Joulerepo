/**
 * The custom logic attached to the MaintenanceTasks entity to validate data before CREATE and UPDATE events, ensuring data integrity and compliance with business rules.
 * @Before(event = { "CREATE","UPDATE" }, entity = "jouleSrv.MaintenanceTasks")
 * @param {cds.Request} request - User information, tenant-specific CDS model, headers and query parameters
 */
module.exports = async function(request) {
  const { MaintenanceTasks, Assets } = cds.entities;
  const { data } = request;

  // Check if the asset association is defined
  if (!data.asset_ID) {
    return request.error(400, 'Asset association is mandatory.');
  }

  // Validate the status field
  const validStatuses = ['Scheduled', 'In Progress', 'Completed', 'Cancelled'];
  if (data.status && !validStatuses.includes(data.status)) {
    return request.error(400, `Invalid status. Valid statuses are: ${validStatuses.join(', ')}.`);
  }

  // Check if the scheduledDate is defined and is a valid date
  if (!data.scheduledDate || isNaN(new Date(data.scheduledDate).getTime())) {
    return request.error(400, 'Scheduled date is mandatory and must be a valid date.');
  }

  // Ensure that completedDate is not before scheduledDate
  if (data.completedDate && new Date(data.completedDate) < new Date(data.scheduledDate)) {
    return request.error(400, 'Completed date cannot be before the scheduled date.');
  }

  // Verify the asset exists
  const asset = await SELECT.one.from(Assets).where({ ID: data.asset_ID });
  if (!asset) {
    return request.error(404, 'Associated asset not found.');
  }

  // Additional business rule checks can be added here
};
