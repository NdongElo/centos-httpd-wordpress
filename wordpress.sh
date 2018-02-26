#!/bin/bash

cd /var/www/html

wget https://wordpress.org/latest.tar.gz 

tar -xvf latest.tar.gz 

rm -f latest.tar.gz 

mv /var/www/html/wordpress/* /var/www/html

rm -rf /var/www/html/wordpress 

chown -R apache:apache /var/www/html 

chmod -R 755 /var/www/html
