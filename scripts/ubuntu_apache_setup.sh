#!/bin/sh

APACHE_CONFIG=/etc/apache2

echo "installing apache2"
sudo apt-get install apache2

echo "enabling rewrite and proxy modules"
sudo ln -s ${APACHE_CONFIG}/mods-available/rewrite.load ${APACHE_CONFIG}/mods-enabled/
sudo ln -s ${APACHE_CONFIG}/mods-available/proxy.load ${APACHE_CONFIG}/mods-enabled/
sudo ln -s ${APACHE_CONFIG}/mods-available/proxy_http.load ${APACHE_CONFIG}/mods-enabled/

echo "setup groupserver configuration"
sudo cp apache-groupserver ${APACHE_CONFIG}/sites-available/groupserver
sudo ln -s ${APACHE_CONFIG}/sites-available/groupserver ${APACHE_CONFIG}/sites-enabled/

echo "starting apache"
sudo /etc/init.d/apache2 restart

