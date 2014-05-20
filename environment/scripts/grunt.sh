#!/bin/bash

echo "Installing Grunt & Grunt CLI by NPM"
npm install -y -g grunt-cli

cd /vagrant
if [ -r "package.json" ]
then
	echo "Installing declared packages from package.json"
	npm install --save-dev --no-bin-links
	echo "Running grunt default (with --force if this is an empty project)"
	grunt build --force
	grunt
else
	echo "WARNING: There was no (readable) package.json. Create one and run 'npm install --save-dev --no-bin-links' to install manually."
fi;