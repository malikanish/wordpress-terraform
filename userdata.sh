#!/bin/bash

set -e
set -x
MYSQL_ROOT_PASSWORD="rootpassword"
WP_DB_NAME="wordpress"
WP_DB_USER="wpuser"
WP_DB_PASS="password"
WP_DIR="/var/www/html"

apt update && apt upgrade -y
apt install -y apache2 mysql-server php libapache2-mod-php php-mysql php-curl php-xml php-mbstring php-zip wget unzip

# Start services
systemctl enable apache2
systemctl start apache2
systemctl enable mysql
systemctl start mysql

mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS $WP_DB_NAME;
CREATE USER IF NOT EXISTS '$WP_DB_USER'@'localhost' IDENTIFIED BY '$WP_DB_PASS';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

rm -rf ${WP_DIR:?}/*

cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress/* "$WP_DIR"

cd "$WP_DIR"
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$WP_DB_NAME/" wp-config.php
sed -i "s/username_here/$WP_DB_USER/" wp-config.php
sed -i "s/password_here/$WP_DB_PASS/" wp-config.php


chown -R www-data:www-data "$WP_DIR"
chmod -R 755 "$WP_DIR"


systemctl restart apache2

echo "✅ WordPress is installed! Access it via http://your_server_ip"
