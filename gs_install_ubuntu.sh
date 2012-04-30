#!/bin/bash

. read_ini.sh

read_ini config.cfg config --prefix CFG

# install packages
sudo apt-get install -y python python-virtualenv python-dev build-essential postgresql libpq-dev libxslt1-dev libxml2-dev python-libxslt1 swaks

echo "Testing mail setup..."
echo
for tmail in ${CFG__config__admin_email} ${CFG__config__user_email}
do
    if [ "${CFG__config__smtp_user}" != "" ]; then
        swaks -S -s ${CFG__config__smtp_host} -p ${CFG__config__smtp_port} --from ${CFG__config__support_email} --to ${tmail} --auth-user ${CFG__config__smtp_user}  --auth-pass ${CFG__config__smtp_pass}
    else
        swaks -S -s ${CFG__config__smtp_host} -p ${CFG__config__smtp_port} --from ${CFG__config__support_email} --to ${tmail}
    fi

    if [ $? -eq 0 ]; then
        echo "Expect an email at ${tmail} from ${CFG__config__support_email}!"
    else
        echo
        echo "There was a problem with the mail configuration. This must be fixed before proceeding with the installation."
        exit
    fi
done

virtualenv --no-site-packages . 

# setup the environment
. ./bin/activate

# fetch build here
pip install zc.buildout==1.5.2

# initialise PostgreSQL database
sudo su -l -c"createuser -D -S -R -l ${CFG__config__pgsql_user}" postgres
sudo su -l -c"createuser -D -S -R -l ${CFG__config__relstorage_user}" postgres

sudo su -l -c"createdb -Ttemplate0 -EUTF-8 ${CFG__config__pgsql_dbname}" postgres
sudo su -l -c"createdb -Ttemplate0 -EUTF-8 ${CFG__config__relstorage_dbname}" postgres

sudo su -l -c"echo \"alter user ${CFG__config__pgsql_user} with encrypted password '${CFG__config__pgsql_password}';\" | psql" postgres
sudo su -l -c"echo \"alter user ${CFG__config__relstorage_user} with encrypted password '${CFG__config__relstorage_password}';\" | psql" postgres

sudo su -l -c"echo \"grant all privileges on database ${CFG__config__pgsql_dbname} to ${CFG__config__pgsql_user};\" | psql" postgres
sudo su -l -c"echo \"grant all privileges on database ${CFG__config__relstorage_dbname} to ${CFG__config__relstorage_user};\" | psql" postgres

echo "${CFG__config__pgsql_host}:${CFG__config__pgsql_port}:${CFG__config__pgsql_dbname}:${CFG__config__pgsql_user}:${CFG__config__pgsql_password}" > pgpass-tmp
chmod 600 pgpass-tmp

export PGPASSFILE=pgpass-tmp

createlang -U${CFG__config__pgsql_user} -h${CFG__config__pgsql_host} -p${CFG__config__pgsql_port} plpgsql ${CFG__config__pgsql_dbname}
buildout -vN

rm pgpass-tmp
