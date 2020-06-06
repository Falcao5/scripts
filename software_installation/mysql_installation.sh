#!/bin/bash

# This script will install mysql server and client on your system.
# After installation, this will configure mysql to be accessible from everywhere (not only localhost).
# Will be created a database, and a user with all permissions on that database.

DB_NAME=place_here_your_database_name
USERNAME=place_here_you_database_username
PASSWORD=place_here_your_password

ROOT_PASSWORD=r00t

PORT=3306

echo "=============================================================================="
echo "INSTALLING MYSQL" 
echo "=============================================================================="

# Setting MySQL root user password
debconf-set-selections <<< "mysql-server mysql-server/root_password password $ROOT_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $ROOT_PASSWORD"

### installation
echo "******* Installation..."

# Install packages
export DEBIAN_FRONTEND=noninteractive # to avoid provisioning break
apt-get install -y mysql-server mysql-client

### application configuration
echo "******* Application configuration..."

# Allow External Connections on your MySQL Service
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Config port forwarding
sudo sed -i "s/port\s*=\s3306/port = $PORT/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i "s/#+\s*port\s*=\s*3306/port = $PORT/" /etc/mysql/mysql.conf.d/mysqld.cnf # change even commented lines

echo "=============================================================================="
echo "RESTARTING MYSQL"
echo "=============================================================================="

sudo service mysql restart

echo "=============================================================================="
echo "CREATING MYSQL USER '$USERNAME'"
echo "=============================================================================="
CREATE_USER_QUERY="CREATE USER '$USERNAME'@'%' IDENTIFIED BY '$PASSWORD';"	# % means everyone
GIVE_PRIVILEGES_QUERY="GRANT ALL PRIVILEGES ON *.* TO '$USERNAME'@'%' WITH GRANT OPTION;"	# % means everyone

# Create user
mysql -uroot -p$ROOT_PASSWORD -e "$CREATE_USER_QUERY"
mysql -uroot -p$ROOT_PASSWORD -e "$GIVE_PRIVILEGES_QUERY"
mysql -uroot -p$ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

# Create database
mysql -uroot -p$ROOT_PASSWORD -e "CREATE DATABASE $DB_NAME;"