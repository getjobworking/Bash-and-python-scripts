#!/bin/bash

# Description: This script sets up a new virtual host in Apache.
# Usage: ./setup_virtual_host.sh <domain_name>
# Example: ./setup_virtual_host.sh mojadomena.local

if [ $# -lt 1 ]; then
    echo "Usage: $0 <domain_name>"
    exit 1
fi

# Extract domain name from the parameter
domain="$1"
folder="/var/www/$domain"

# Create the directory structure
sudo mkdir -p "$folder/public_html"
sudo mkdir -p "$folder/logs"

# Create a sample index.html file
echo "<html><head><title>Welcome to $domain</title></head><body><h1>Success! The $domain virtual host is working!</h1></body></html>" | sudo tee "$folder/public_html/index.html" > /dev/null

# Create the Apache configuration file
conf_file="/etc/apache2/sites-available/$domain.conf"
echo "<VirtualHost *:80>
    ServerName $domain
    ServerAlias www.$domain
    ServerAdmin webmaster@$domain
    DocumentRoot /var/www/$domain/public_html

    <Directory /var/www/$domain/public_html>
        Options -Indexes +FollowSymLinks
        AllowOverride All
    </Directory>

    ErrorLog /var/www/$domain/logs/$domain-error.log
    CustomLog /var/www/$domain/logs/$domain-access.log combined
</VirtualHost>" | sudo tee "$conf_file" > /dev/null

# Find the last existing entry with the IP address 127.0.0.1
last_entry=$(grep -E '^127\.0\.0\.1\s+' /etc/hosts | tail -n 1)

# Add the new domain after the last existing entry
if [ -n "$last_entry" ]; then
    sudo sed -i "s/$last_entry/$last_entry\n127.0.0.1\t$domain/g" /etc/hosts
else
    echo "127.0.0.1\t$domain" | sudo tee -a /etc/hosts > /dev/null
fi

# Enable the virtual host
sudo a2ensite "$domain.conf"

# Test the Apache configuration
sudo apachectl configtest

# Restart Apache
sudo systemctl restart apache2

# Set ownership and permissions
sudo chown -R "$USER":www-data "$folder/public_html"
sudo chmod -R g+s "$folder/public_html"

echo "Setup for $domain is complete."