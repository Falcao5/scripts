#!/bin/bash

# This scripts install PostgreSQL (specific version can be configured below), and configures it to accept IPv4 and IPv6 connections coming from anywhere (not only localhost)

# ref: https://opensource.com/article/17/10/set-postgres-database-your-raspberry-pi
# prerequisite: you must be logged in with a user with sudo power.

### installation configuration
echo "******* Installation configuration..."

# surely working versions for this script: 10, 11
POSTGRESQL_VERSION=11
POSTGRESQL_CLIENT_VERSION=11

### installation
echo "******* Installation..."

sudo apt-get update
sudo apt-get install postgresql-$POSTGRESQL_VERSION libpq-dev postgresql-client-$POSTGRESQL_VERSION

## application configuration
echo "******* Application configuration..."

# listen on local network
sudo sed -i "s/#listen_addresses.*/listen_addresses = \'*\'/" /etc/postgresql/$POSTGRESQL_VERSION/main/postgresql.conf
sudo sed -i 's/127.0.0.1\/32/0.0.0.0\/0/' /etc/postgresql/$POSTGRESQL_VERSION/main/pg_hba.conf
sudo sed -i 's/::1\/128/::\/0/' /etc/postgresql/$POSTGRESQL_VERSION/main/pg_hba.conf

sudo service postgresql restart