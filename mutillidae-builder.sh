#!/bin/bash
# Mutillidae II Builder
# Built and Tested on Ubuntu 18.10 (Cosmic)

# Get the latest update files
apt-get update -y

# Install Apache2
apt-get install apache2 -y

# Enabled modules
a2enmod rewrite

# Install php and apache-to-php libraries
apt-get install php libapache2-mod-php -y

# Install mysql and php-to-mysql libraries
apt-get install mysql-server php-mysql -y 

# Install additional dependencies
apt-get install php7.2-curl php7.2-mbstring php7.2-xml -y 

# Pull the mutillidae web root to the apache web root
git clone https://github.com/webpwnized/mutillidae.git /var/www/html/mutillidae 

# Start/Restart Apache services
service apache2 restart

# Start/Restart MySQL services
service mysql restart

# Change MySQL root password to 'mutillidae'
mysql -u root -Bse "use mysql;update user set authentication_string=PASSWORD('mutillidae') where user='root';update user set plugin='mysql_native_password' where user='root';flush privileges;"

# 
myip=$(ifconfig |grep inet |head -n1 |awk '{print$2}')
echo ""
echo " - You may now access Mutillidae at: http://$myip/mutillidae/ - "
echo " - Remeber to Reset DB! - "
