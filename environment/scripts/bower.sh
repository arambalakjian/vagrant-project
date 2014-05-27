#!/bin/bash
echo -e "\e[42;33mInstalling Bower\e[0m"
npm install -y -g bower
cd /vagrant
if [ -r "bower.json" ]
	then
		echo -e "\e[42;33mInstalling declared packages from bower.json\e[0m"
		bower --allow-root -y install
	else
		echo -e "\e[41;93mWARNING: There was no (readable) bower.json\e[0m"
fi