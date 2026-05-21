#!/bin/bash

apt-get update

apt-get install -y nginx

mkdir -p /var/www/html

cp -r /vagrant/html/* /var/www/html/

systemctl enable nginx
systemctl restart nginx