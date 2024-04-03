#!/bin/bash

sudo su -
apt update -y

apt install apache2 -y

apt install git -y

rm /var/www/html/index.html

git clone https://github.com/FofuxoSibov/sitebike.git /var/www/html/

systemctl enable apache2
systemctl start apache2

sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/