#!/bin/bash

echo "installing node.js"

echo "add PPA to get latest version of node.js"
apt-get -y install python-software-properties
add-apt-repository -y ppa:chris-lea/node.js
apt-get update
apt-get -y install nodejs

echo "node installed"