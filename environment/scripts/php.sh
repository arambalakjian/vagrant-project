#!/bin/bash

echo "Installing PHP and common modules"
apt-get install -y php5 libapache2-mod-php5 php5-mcrypt php5-gd php5-curl php5-pspell php5-xmlrpc curl

echo "Copying php.ini"
cp -f /vagrant/environment/config/php.ini /etc/php.ini

echo "Restarting Apache"
service apache2 restart

echo "PHP installed"
