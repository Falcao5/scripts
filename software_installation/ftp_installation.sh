#!/bin/bash

# This script allows you to install FTP server, creating a linux user who can access to it, and a first FTP user to login with

# ref: https://www.raspberrypi.org/documentation/remote-access/ftp.md
# prerequisite: you must be logged in with a user with sudo power.

# if pure-ftpd is not installed, install it.
if [ $(dpkg -l | grep pure-ftpd) -z ]; then
### installation
	echo "******* Installation..."
	sudo apt install pure-ftpd
else
	echo "Well, pure-ftpd is installed yet."
fi

### installation configuration
echo "******* Installation configuration..."

FTP_GROUP=group_for_ftp_allowed_users
FTP_LINUX_USER_DIR=/home/username_of_the_user/you_can_create_some_dirs_here
LINUX_FTP_USER=linux_user_allowed_to_use_ftp
FTP_USER=user_in_pureftp_this_is_the_one_that_you_will_use_to_do_ftp_connection

## application configuration
echo "******* Application configuration..."

sudo groupadd $FTP_GROUP
sudo useradd $LINUX_FTP_USER -g $FTP_GROUP -s /sbin/nologin -d /dev/null
sudo mkdir $FTP_LINUX_USER_DIR
sudo chown -R $LINUX_FTP_USER:$FTP_GROUP $FTP_LINUX_USER_DIR
sudo pure-pw useradd $FTP_USER -u $LINUX_FTP_USER -g $FTP_GROUP -d $FTP_LINUX_USER_DIR -m
sudo pure-pw mkdb
sudo ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/60puredb
sudo service pure-ftpd restart