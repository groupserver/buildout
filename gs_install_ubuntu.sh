#!/usr/bin/env bash
##############################################################################
#
# Copyright © 2012, 2014, 2015 OnlineGroups.net and Contributors.
# All Rights Reserved.
#
# This software is subject to the provisions of the Zope Public License,
# Version 2.1 (ZPL).  A copy of the ZPL should accompany this distribution.
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY AND ALL EXPRESS OR IMPLIED
# WARRANTIES ARE DISCLAIMED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF TITLE, MERCHANTABILITY, AGAINST INFRINGEMENT, AND FITNESS
# FOR A PARTICULAR PURPOSE.
#
##############################################################################

# First ensure we are *NOT* *ROOT*
if [[ $(whoami) == 'root' ]]
then
    echo -en "\033[0m\033[31m" >&2
    echo -en "The installation should be done as a "
    echo -en "\033[1m" >&2
    echo -en "normal user," >&2
    echo -e "\033[0m\033[31m" >&2
    echo -en "any user other than root." >&2
    echo -e "\033[0m" >&2
    exit
fi

. read_ini.sh
read_ini config.cfg config --prefix CFG

echo -en "\033[0m\033[1m"
echo -e "Installing dependencies:\033[0m"
echo -e "You will need to authenticate so this script can do this."
echo -e "\033[0m"
sudo apt-get install -y sed python python-virtualenv python-dev build-essential postfix postgresql libpq-dev swaks redis-server libxslt1-dev libjpeg62-dev

echo -e "\033[0m\033[1m"
echo "Testing mail setup..."
echo -en "\033[0m"
if [ "${CFG__config__smtp_user}" != "" ]; then
    swaks -S -s ${CFG__config__smtp_host} -p ${CFG__config__smtp_port} --from ${CFG__config__support_email} --to ${CFG__config__admin_email} --auth-user ${CFG__config__smtp_user}  --auth-pass ${CFG__config__smtp_password}
else
    swaks -S -s ${CFG__config__smtp_host} -p ${CFG__config__smtp_port} --from ${CFG__config__support_email} --to ${CFG__config__admin_email}
fi
if [ $? -eq 0 ]; then
    echo -en "\033[2m"
    echo "Mail setup works. Expect an email at ${CFG__config__admin_email}"
    echo "from ${CFG__config__support_email}."
    echo -en "\033[0m"
else
    echo -e "\033[0m\033[31m" >&2
    echo "There was a problem with the mail configuration. Either install" >&2
    echo "Postfix:" >&2
    echo "    sudo apt-get install postfix" >&2
    echo "Or specify a remote SMTP server in the 'config.cfg' file." >&2
    echo -e '\033[0m' >&2
    exit
fi

echo -e '\033[0m\033[1m'
echo "Testing the network..."
echo -en '\033[0m\033[2m'
ping -q -c1 eggs.iopen.net
if [ $? -eq 0 ]; then
    echo -e '\033[0m'
    echo "Network goes: the GroupServer repository was reached."
    echo -e '\033[0m'
else
    echo -e "\033[0m\033[31m" >&2
    echo "The repository eggs.iopen.net could not be found. Please fix ">&2
    echo "your network settings and try again." >&2
    echo -e '\033[0m' >&2
    exit
fi

# initialise PostgreSQL database
echo -en '\033[0m\033[1m'
echo "Setting up the databases"
echo -e '\033[0m\033[2m'
sudo su -l -c"createuser -p ${CFG__config__pgsql_port} -d -S -R -l ${CFG__config__pgsql_user}" postgres
sudo su -l -c"createuser -p ${CFG__config__relstorage_port} -d -S -R -l ${CFG__config__relstorage_user}" postgres

sudo su -l -c"createdb -p ${CFG__config__pgsql_port} -Ttemplate0 -O ${CFG__config__pgsql_user} -EUTF-8 ${CFG__config__pgsql_dbname}" postgres
sudo su -l -c"createdb -p ${CFG__config__relstorage_port} -Ttemplate0 -O ${CFG__config__relstorage_user} -EUTF-8 ${CFG__config__relstorage_dbname}" postgres

sudo su -l -c"echo \"alter user ${CFG__config__pgsql_user} with encrypted password '${CFG__config__pgsql_password}';\" | psql -p ${CFG__config__pgsql_port}" postgres
sudo su -l -c"echo \"alter user ${CFG__config__relstorage_user} with encrypted password '${CFG__config__relstorage_password}';\" | psql -p ${CFG__config__relstorage_port}" postgres

sudo su -l -c"echo \"grant all privileges on database ${CFG__config__pgsql_dbname} to ${CFG__config__pgsql_user};\" | psql -p ${CFG__config__pgsql_port}" postgres
sudo su -l -c"echo \"grant all privileges on database ${CFG__config__relstorage_dbname} to ${CFG__config__relstorage_user};\" | psql -p ${CFG__config__relstorage_port}" postgres

echo -e '\033[0m'
echo -n "Checking max_prepared_transactions database setting... "
echo -e '\033[0m\033[2m'
MAX_PREPARED_TRANSACTIONS=`sudo su -l -c "psql -p ${CFG__config__pgsql_port} -c 'SHOW max_prepared_transactions;'" postgres | sed -n -r -e 's/^\s*([[:digit:]]+).*$/\1/p'`
POSTGRES_CONFIG_FILE=`sudo su -l -c "psql -p ${CFG__config__pgsql_port} -c 'SHOW config_file;'" postgres | sed -n -r -e '3p' | tr -d ' '`
if [ $MAX_PREPARED_TRANSACTIONS -eq 0 ]; then
    echo "Prepared Transactions not enabled"
    echo "Enabling Prepared Transactions in database"
    sudo sed -i -e 's/^.*max_prepared_transactions = .*$/max_prepared_transactions = 10 \t\t# Set by GroupServer install script/' $POSTGRES_CONFIG_FILE
    sudo service postgresql restart
else
    echo "Prepared transactions already enabled"
fi

# This is not the work of angels, but...
echo "${CFG__config__pgsql_host}:${CFG__config__pgsql_port}:${CFG__config__pgsql_dbname}:${CFG__config__pgsql_user}:${CFG__config__pgsql_password}" > pgpass-tmp
chmod 600 pgpass-tmp
export PGPASSFILE=pgpass-tmp
# ...it works.
echo -en '\033[0m'
echo -n 'Ensuring pl/pgSQL is handled by the database'
echo -e '\033[0m\033[2m'
createlang -h${CFG__config__pgsql_host} -p${CFG__config__pgsql_port} -U${CFG__config__pgsql_user} plpgsql ${CFG__config__pgsql_dbname}
echo -en '\033[0m\033[1m'
echo -n "Databases created"
echo -e '\033[0m'

echo -e '\033[0m\033[1m'
echo "Setting up Python"
echo -e '\033[0m\033[2m'
# Create the Python environment
virtualenv --no-site-packages . 
. ./bin/activate
# Fetch the system that builds GroupServer
pip install zc.buildout==2.3.1
pip install setuptools==18.0.1
buildout -c buildout.cfg bootstrap
echo -en '\033[0m\033[1m'
echo -n "Python setup complete."
echo -e '\033[0m'

echo -e '\033[0m\033[1m'
echo "Installing GroupServer and its dependencies"
echo -en '\033[0m\033[2m'
echo "This will take a while"
echo -e '\033[0m'
buildout -n install
buildout -n -c site.cfg install
# Buildout has its own "completed" message.

rm pgpass-tmp
