# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|


  #Vanilla
  config.vm.box = "Ubuntu precise 64 VirtualBox"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  #---Networking---

  # Port forward 80 to 8080
  #config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
  #config.vm.network :forwarded_port, guest: 443, host: 443, auto_correct: true
  #config.vm.network :forwarded_port, guest: 3306, host: 3306, auto_correct: true
  config.vm.network :forwarded_port, guest: 35729, host: 35729, auto_correct: true # LiveReload
  config.vm.network "private_network", ip: "192.168.33.10"

  #Uncomment this if you want bridged network functionality
  #config.vm.network :public_network

  #Install lamp and so on
  #In future will probably swap this out with something like Puppet
  #config.vm.provision :shell, :path => "environment/scripts/iptables.sh"
  config.vm.provision :shell, :path => "environment/scripts/apache.sh"
  config.vm.provision :shell, :path => "environment/scripts/php.sh"
  #config.vm.provision :shell, :path => "environment/scripts/php-55.sh"
  config.vm.provision :shell, :path => "environment/scripts/mysql.sh"
  config.vm.provision :shell, :path => "environment/scripts/phpmyadmin.sh"
  #config.vm.provision :shell, :path => "environment/scripts/mariadb-5.5.sh"
  #config.vm.provision :shell, :path => "environment/scripts/php-geoip.sh"
  config.vm.provision :shell, :path => "environment/scripts/php-pear-phpunit.sh"
  #config.vm.provision :shell, :path => "environment/scripts/php-xdebug.sh"
  #config.vm.provision :shell, :path => "environment/scripts/php-apc.sh"
  #config.vm.provision :shell, :path => "environment/scripts/mongo.sh"
  #config.vm.provision :shell, :path => "environment/scripts/php-mongo.sh"
  #config.vm.provision :shell, :path => "environment/scripts/ntp.sh"
  config.vm.provision :shell, :path => "environment/scripts/node.sh"
  config.vm.provision :shell, :path => "environment/scripts/composer.sh"
  #config.vm.provision :shell, :path => "environment/scripts/libjpeg-jpegoptim.sh"
  #config.vm.provision :shell, :path => "environment/scripts/optipng.sh"
  #config.vm.provision :shell, :path => "environment/scripts/sass.sh"
  #config.vm.provision :shell, :path => "environment/scripts/grunt-watch.sh"
  config.vm.provision :shell, :path => "environment/scripts/silverstripe-tasks.sh"
  #config.vm.provision :shell, :path => "environment/scripts/bootstrap.sh"
  config.vm.provision :shell, :path => "environment/scripts/bower.sh"
  config.vm.provision :shell, :path => "environment/scripts/grunt.sh"

  config.vm.synced_folder "node_modules/", "/vagrant/node_modules/", disabled: true

end
