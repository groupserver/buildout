#!/bin/bash

DBNAME="test123"
DBUSER="test123"
DBPASS="test123"
DBHOST="localhost"
DBPORT="5432"

RELSTORAGEDBNAME="${DBNAME}zodb"
RELSTORAGEDBUSER="${DBUSER}"
RELSTORAGEDBPASS="${DBPASS}"
RELSTORAGEDBHOST="${DBHOST}"
RELSTORAGEDBPORT="${DBPORT}"

# The support email address for the new sites.
SUPPORTEMAILFROM="support@iopen.net"
ADMINEMAILTO="richard@iopen.net"
USEREMAILTO="test12@iopen.net"

# The SMTP connection settings, used for notification delivery. By
#   default, the localhost is used with no authentication.
SMTPHOST="smtp.iopen.net"
SMTPPORT="25"
SMTPUSER="richard"
SMTPPASS="diawrt1"

echo "Testing mail setup:\n"
if [ "${SMTPUSER}" != "" ];
then
  swaks -S -s ${SMTPHOST} -p ${SMTPPORT} --from ${SUPPORTEMAILFROM} --to ${ADMINEMAILTO} --auth-user ${SMTPUSER} --auth-pass ${SMTPPASS}
else
  swaks -S -s ${SMTPHOST} -p ${SMTPPORT} --from ${SUPPORTEMAILFROM} --to ${ADMINEMAILTO}
fi

if [ $? -eq 0 ];
then
  echo "Mail setup looks good. Expect email!"
else
  echo "\nThere was a problem with the mail configuration. This must be fixed before proceeding with the installation."
fi

exit

CONFIG_TEMPLATE="config.template"

# install packages
sudo apt-get install -y python python-virtualenv python-dev build-essential postgresql libpq-dev libxslt1-dev libxml2-dev python-libxslt1 swaks

virtualenv --no-site-packages . 

# setup the environment
. ./bin/activate

# fetch build here
pip install zc.buildout==1.5.2

# fill the config template
echo "$(eval "echo \"$(cat ${CONFIG_TEMPLATE})\"")" > config.cfg

# initialise PostgreSQL database
sudo su -l -c"createuser -D -S -R -l ${DBUSER}" postgres
sudo su -l -c"createuser -D -S -R -l ${RELSTORAGEDBUSER}" postgres

sudo su -l -c"createdb -Ttemplate0 -EUTF-8 ${DBNAME}" postgres
sudo su -l -c"createdb -Ttemplate0 -EUTF-8 ${RELSTORAGEDBNAME}" postgres

sudo su -l -c"echo \"alter user ${DBUSER} with encrypted password '${DBPASS}';\" | psql" postgres
sudo su -l -c"echo \"alter user ${RELSTORAGEDBUSER} with encrypted password '${RELSTORAGEDBPASS}';\" | psql" postgres

sudo su -l -c"echo \"grant all privileges on database ${DBNAME} to ${DBUSER};\" | psql" postgres
sudo su -l -c"echo \"grant all privileges on database ${RELSTORAGEDBNAME} to ${RELSTORAGEDBUSER};\" | psql" postgres

echo "${DBHOST}:${DBPORT}:${DBNAME}:${DBUSER}:${DBPASS}" > pgpass-tmp
chmod 600 pgpass-tmp

export PGPASSFILE=pgpass-tmp

createlang -U${DBUSER} -h${DBHOST} -p ${DBPORT} plpgsql ${DBNAME}
buildout -vN

rm pgpass-tmp
