#!/bin/bash

echo "Installing Grunt & Grunt CLI by NPM"
npm install -y -g grunt-cli

cd /vagrant
if [ -r "package.json" ]
then
	echo "Installing declared packages from package.json"
	mkdir /node
	cp /vagrant/package.json /node/package.json
	cd /node
	npm install --save-dev --no-bin-links
	ln -s /node/node_modules /vagrant/node_modules
	cd /vagrant


	echo "Running grunt default (with --force if this is an empty project)"
	grunt build --force
else
	echo "WARNING: There was no (readable) package.json. Create one and run 'npm install --save-dev --no-bin-links' to install manually."
fi;