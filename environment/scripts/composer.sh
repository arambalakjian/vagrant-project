#!/bin/bash

# Grab the installer and pipe it into PHP
echo "Downloading composer"
curl -sS https://getcomposer.org/installer | php

echo "Moving composer to make it globally accessable"
mv composer.phar /usr/bin/composer

echo "Composer installed"

echo "Installing git due to composer dependency"
apt-get install -y git

VHOST_FILES=/vagrant/vhosts/*

for file in $VHOST_FILES
do
	FILENAME=$(basename "$file")
	cd /var/www/$FILENAME/public_html
	if [ -r "composer.json" ]
	then
		echo "Installing declared packages from composer.json"
		composer install
	else
		echo "WARNING: There was no (readable) composer.json. Create one and run 'composer install' to install dependencies."
	fi;
done;

