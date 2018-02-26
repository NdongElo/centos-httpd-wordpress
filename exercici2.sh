#/bin/bash

docker network create exercici2


docker create  --name datacontainer -v /var/lib/mysql -v /var/www/html busybox


docker run  --name=mariadb -p 3309:3309 -d -e MYSQL_ROOT_PASSWORD=mariadb -e MYSQL_DATABASE=db -e MYSQL_USER1=aurelio -e MYSQL_PASSWORD1=aurelio   --network exercici2  --volumes-from datacontainer orboan/dcsss-mariadb


docker run  --name=apache1 -p 8585:80 -p 2222:22 -d  --network exercici2  --volumes-from datacontainer ndongelo/centos-httpd-php


