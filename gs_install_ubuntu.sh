#!/bin/bash

# First ensure we are *NOT* *ROOT*
if [[ $(whoami) == 'root' ]]
then
  echo "The installation should be done as a normal user,"
  echo "any user other than root."
  exit
fi

. read_ini.sh
read_ini config.cfg config --prefix CFG

echo "Installing dependencies:"
echo "You will need to authenticate so this script can do this."
echo
sudo apt-get install -y sed python python-virtualenv python-dev build-essential postfix postgresql libpq-dev swaks redis-server libxslt-dev libjpeg62-dev

echo
echo "Testing mail setup..."
echo
if [ "${CFG__config__smtp_user}" != "" ]; then
    swaks -S -s ${CFG__config__smtp_host} -p ${CFG__config__smtp_port} --from ${CFG__config__support_email} --to ${CFG__config__admin_email} --auth-user ${CFG__config__smtp_user}  --auth-pass ${CFG__config__smtp_password}
else
    swaks -S -s ${CFG__config__smtp_host} -p ${CFG__config__smtp_port} --from ${CFG__config__support_email} --to ${CFG__config__admin_email}
fi
if [ $? -eq 0 ]; then
    echo "Mail setup works. Expect an email at ${CFG__config__admin_email}"
    echo "from ${CFG__config__support_email}."
    echo
else
    echo
    echo
    echo "There was a problem with the mail configuration. Either install"
    echo "Postfix:"
    echo "    sudo apt-get install postfix"
    echo "Or specify a remote SMTP server in the 'config.cfg' file."
    exit
fi

echo
echo "Testing the network..."
echo
ping -q -c1 eggs.iopen.net
if [ $? -eq 0 ]; then
    echo "Can reach the GroupServer repository."
    echo
else
    echo "The repository eggs.iopen.net could not be found. Please fix your "
    echo "network settings and try again."
    exit
fi

# initialise PostgreSQL database
echo
echo "Setting up the databases"
echo
sudo su -l -c"createuser -p ${CFG__config__pgsql_port} -d -S -R -l ${CFG__config__pgsql_user}" postgres
sudo su -l -c"createuser -p ${CFG__config__relstorage_port} -d -S -R -l ${CFG__config__relstorage_user}" postgres

sudo su -l -c"createdb -p ${CFG__config__pgsql_port} -Ttemplate0 -O ${CFG__config__pgsql_user} -EUTF-8 ${CFG__config__pgsql_dbname}" postgres
sudo su -l -c"createdb -p ${CFG__config__relstorage_port} -Ttemplate0 -O ${CFG__config__relstorage_user} -EUTF-8 ${CFG__config__relstorage_dbname}" postgres

sudo su -l -c"echo \"alter user ${CFG__config__pgsql_user} with encrypted password '${CFG__config__pgsql_password}';\" | psql -p ${CFG__config__pgsql_port}" postgres
sudo su -l -c"echo \"alter user ${CFG__config__relstorage_user} with encrypted password '${CFG__config__relstorage_password}';\" | psql -p ${CFG__config__relstorage_port}" postgres

sudo su -l -c"echo \"grant all privileges on database ${CFG__config__pgsql_dbname} to ${CFG__config__pgsql_user};\" | psql -p ${CFG__config__pgsql_port}" postgres
sudo su -l -c"echo \"grant all privileges on database ${CFG__config__relstorage_dbname} to ${CFG__config__relstorage_user};\" | psql -p ${CFG__config__relstorage_port}" postgres

echo -n "Checking max_prepared_transactions database setting... "
MAX_PREPARED_TRANSACTIONS=`sudo su -l -c "psql -p ${CFG__config__pgsql_port} -c 'SHOW max_prepared_transactions;'" postgres | sed -n -r -e 's/^\s*([[:digit:]]+).*$/\1/p'`
POSTGRES_CONFIG_FILE=`sudo su -l -c "psql -p ${CFG__config__pgsql_port} -c 'SHOW config_file;'" postgres | sed -n -r -e '3p' | tr -d ' '`
if [ $MAX_PREPARED_TRANSACTIONS -eq 0 ]; then
    echo "Prepared Transactions not enabled"
    echo "Enabling Prepared Transactions in database"
    sudo sed -i -e 's/^.*max_prepared_transactions = .*$/max_prepared_transactions = 10 \t\t# Set by GroupServer install script/' $POSTGRES_CONFIG_FILE
    sudo service postgresql restart
else
    echo "Prepared Transactions already enabled"
fi

# This is not the work of angels, but...
echo "${CFG__config__pgsql_host}:${CFG__config__pgsql_port}:${CFG__config__pgsql_dbname}:${CFG__config__pgsql_user}:${CFG__config__pgsql_password}" > pgpass-tmp
chmod 600 pgpass-tmp
export PGPASSFILE=pgpass-tmp
# ...it works.
createlang -h${CFG__config__pgsql_host} -p${CFG__config__pgsql_port} -U${CFG__config__pgsql_user} plpgsql ${CFG__config__pgsql_dbname}
echo
echo "Databases created"
echo

echo "Setting up Python"
echo
# Create the Python environment
virtualenv --no-site-packages . 
. ./bin/activate
# Fetch the system that builds GroupServer
pip install zc.buildout==2.3.1
echo
echo "Python setup complete."

echo
echo "Installing GroupServer"
echo
buildout -N
# Buildout has its own "completed" message.

rm pgpass-tmp
