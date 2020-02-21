
#!/bin/bash
ipaddress=$(ip a | grep inet | grep 192 | awk '{print $2}' | cut -d "/" -f 1)
function nextcloud(){
apt install mlocate apache2 libapache2-mod-php mariadb-client mariadb-server wget unzip bzip2 curl php php-common php-curl php-gd php-mbstring php-mysql php-xml php-zip php-intl php-apcu php-redis php-http-request

cat <<EOF>> /etc/apache2/sites-available/nextcloud.conf
<VirtualHost *:80>
ServerAdmin webmaster@localhost
DocumentRoot /var/www/nextcloud
Alias /nextcloud "/var/www/nextcloud/"
 
<Directory "/var/www/nextcloud/">
Options +FollowSymlinks
AllowOverride All
 
<IfModule mod_dav.c>
Dav off
</IfModule>
 
Require all granted
 
SetEnv HOME /var/www/nextcloud
SetEnv HTTP_HOME /var/www/nextcloud
</Directory>
 
ErrorLog ${APACHE_LOG_DIR}/nextcloud_error_log
CustomLog ${APACHE_LOG_DIR}/nextcloud_access_log common
</VirtualHost>
EOF
cat <<EOF>> /tmp/sql-inject
CREATE DATABASE nextcloud;
CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'YOUR_PASSWORD_HERE';
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';
FLUSH PRIVILEGES;
EOF

systemctl restart mysql

mysql -u root -p < /tmp/sql-inject
cd /var/www
wget https://download.nextcloud.com/server/releases/nextcloud-18.0.1.zip
unzip nextcloud-18.0.1.zip
mkdir nextcloud/data
chown -R www-data:www-data nextcloud
a2ensite nextcloud.conf
a2dissite 000-default.conf
systemctl restart apache2
systemctl enable apache2 mariadb
clear
echo "Nextcloud installed, open the browser on https://${ipaddress}/nextcloud"
echo "to continue the configuration"
}

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
else nextcloud
fi
