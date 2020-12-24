#!/bin/bash

/etc/init.d/postgresql start

# su - postgres
psql -U postgres -c "CREATE USER root PASSWORD '1q2w3e4r' SUPERUSER;"
psql -U postgres -c "CREATE DATABASE test OWNER root;"
psql -U postgres -c "CREATE DATABASE root OWNER root;"
# psql -c "\c test root"

# nano /etc/postgresql/13/main/pg_hba.conf
# /etc/init.d/postgresql restart

bash