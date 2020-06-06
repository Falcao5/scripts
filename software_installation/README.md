# software_installation
In this directory you can find scripts to automate installation

### postgresql_10_11_apt_installation.sh
Installation for PostgreSQL 10 or 11 and PostgreSQL CLI client. Uses apt. Admits IPv4 and IPv6 connections coming from anywhere.
### ftp_installation.sh
This script allows you to install FTP server, creating a linux user who can access to it, and a first FTP user to login with. Uses apt.
### git_installation.sh
Installs git (latest version) on system. Uses apt.
### mysql_installation.sh
This script will install mysql server and client on your system. After installation, this will configure mysql to be accessible from everywhere (not only localhost). Will be created a database, and a user with all permissions on that database.
