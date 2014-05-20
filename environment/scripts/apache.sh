#!/bin/bash

## TODOs ##
# Make sure following modules are installed for html5 boilerplate htaccess #
# setenvif
# headers
# mime
# rewrite
# autoindex
# authz_core
# deflate
# filter
# expires
# include


echo "Installing Apache"
apt-get update
apt-get install -y apache2

apt-get install -y sysv-rc-conf
sysv-rc-conf apache2 on

#echo "Copying httpd config"
#cp -f /vagrant/environment/config/httpd.conf /etc/apache2/httpd.conf

echo "Copy vhosts over"
if [ -d /vagrant/vhosts ]
then
	cp -r /vagrant/vhosts/* /etc/apache2/sites-available
fi

echo "Mounting webroot"

# pick the webroot

if [ -d /vagrant/public_html ]
then
VHOST_FILES=/vagrant/vhosts/*
for file in $VHOST_FILES
do
	FILENAME=$(basename "$file")
	echo $FILENAME
	if [ -d /var/www/$FILENAME ]
	then
		rm -rf /var/www/$FILENAME
	fi
	mkdir -p /var/www/$FILENAME
	ln -s /vagrant/public_html /var/www/$FILENAME
	a2ensite $FILENAME
done;
else
	echo "Can't find webroot. Quitting..."
	exit 1
fi



echo "Enable mod rewrite"
a2enmod rewrite

echo "Starting httpd service"
service apache2 start

echo "Apache installed"
