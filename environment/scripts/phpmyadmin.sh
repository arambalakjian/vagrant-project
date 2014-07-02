#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password '''
debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password '''
debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password '''
debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'
apt-get install -y phpmyadmin
sed -i "s/\ \ \ \ \/\/\ \$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\]/\ \ \ \ \$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\]/g" /etc/phpmyadmin/config.inc.php
