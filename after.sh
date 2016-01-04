#!/bin/sh

# If you would like to do some extra provisioning you may
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

sudo touch /etc/apt/sources.list.d/mongodb-org-3.0.list

sudo echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee
/etc/apt/sources.list.d/mongodb-org-3.0.list

sudo apt-get update

sudo pecl install mongo

sudo apt-get install -y mongodb-org

# Requred to use Locale class in PHP 5
sudo apt-get install php5-intl

sudo service mongod start

mongo --eval 'use admin'
mongo --eval 'db.createUser({ user: "admin", pwd: "admin", roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]})'

cd /var/www/paleale
php artisan migrate
