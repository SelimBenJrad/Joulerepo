const nodemailer = require('nodemailer');

// Configure your email transporter
const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com', // Replace with your SMTP server
    port: 587,
    secure: false,
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASSWORD
    }
});

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
    
    // Send email notification for task creation
    if (request.event === 'CREATE') {
        try {
            await transporter.sendMail({
                from: process.env.EMAIL_USER,
                to: 'dhia.djobbi@gmail.com', // Replace with actual recipient
                subject: 'New Maintenance Task Created',
                text: `A new maintenance task has been created.\n\nTask Details:\n${JSON.stringify(data, null, 2)}`
            });
            
        } catch (error) {
            console.error('Failed to send email notification:', error);
            // Don't fail the request if email fails
        }
    }
    
    // Proceed to the next handler
    return next();
}