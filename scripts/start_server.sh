#!/bin/bash
echo "Starting deployment script..."
echo "Deployment started at: $(date)"

# Ensure Apache is installed and running
sudo yum install -y httpd
echo "Apache web server installed"

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd
echo "Apache web server started and enabled"

# Backup existing website (if any)
if [ -f /var/www/html/index.html ]; then
    sudo cp /var/www/html/index.html /var/www/html/index.html.backup.$(date +%Y%m%d-%H%M%S)
    echo "Existing website backed up"
fi

# Set proper permissions
sudo chmod 644 /var/www/html/index.html
sudo chown apache:apache /var/www/html/index.html
echo "File permissions set correctly"

# Restart Apache to ensure changes take effect
sudo systemctl restart httpd
echo "Apache web server restarted"

# Verify Apache is running
if sudo systemctl is-active --quiet httpd; then
    echo "✅ Application deployed successfully!"
    echo "✅ Web server is running properly"
    echo "✅ Deployment completed at: $(date)"
else
    echo "❌ Error: Web server is not running"
    exit 1
fi