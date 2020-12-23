#!/bin/bash

apt-get -y install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
apt-get -y update
apt-get -y install postgresql postgresql-contrib
# /etc/init.d/postgresql start

# curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | apt-key add
# sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
# apt-get install -y pgadmin4

# # Configure the webserver, if you installed pgadmin4-web:
# /usr/pgadmin4/bin/setup-web.sh