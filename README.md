# centos-httpd-wordpress
This repository contain a Dockerfile to build a data container image that mount DocumentRoot for apache, and install **wordpress** in the directory and also mount it on the host machine, it’s also contain a script file that have all the commands that you have to run to create containers. 

## Base Docker Image
* centos
### Use of this image
You can use this repository to create data container witch will map on DocumentRoot directories /var/www/html for apache server and /var/lib/mysql for mariadb.

### Prerequisites 

**$ docker network create exercici2**
 
First we need create a network that we will use while creating containers

**$ docker create --name datacontainer --network exercici2 -v /var/lib/mysql -v /var/www/html  busybox**

Then we create a container with this image.

## Docker run example:
Here I am using **orboan/dcsss-mariadb** image to create a container based on mariadb here we create a     
database for our **wordpress**.

With **--name** you can give a name to you container at container creation time.

With **MYSQL_ROOT_PASSWORD** enviroment variable you can set the mariadb root password at container creation time.

With **MYSQL_DATABASE1**, **MYSQL_USER1**, **MYSQL_PASSWORD1** you can create a mysql db, user with all privileges upon this db, and its password, at container creation time.With **--name** you can give a name to you container at container creation time.

With **MYSQL_ROOT_PASSWORD** enviroment variable you can set the mariadb root password at container creation time.

With **3306:3306** we use to maps the mariadb server.

With **MYSQL_DATABASE1**, **MYSQL_USER1**, **MYSQL_PASSWORD1** you can create a mysql db, user with all privileges upon this db, and its password, at container creation time.
**docker run  --name=mariadb -p 3309:3309 -d -e MYSQL_ROOT_PASSWORD=mariadb -e MYSQL_DATABASE=db -e MYSQL_USER1=aurelio -e MYSQL_PASSWORD1=aurelio   --network exercici2  --volumes-from datacontainer orboan/dcsss-mariadb
**

**$docker run  --name=apache -p 8585:80 -p 2222:22 -d  --network exercici2  --volumes-from datacontainer ndongelo/centos-httpd-php
 **

We also use **-d** option for container to run in background and print container ID.

With **2222:22** we use to maps the ssh for putty conection.

With this command we create an apache based container with image **ndongelo/centos-httpd-php** (it’s an image of apache with php installed). 

With **--name** you can give a name to you container at container creation time. 

With **-p 8585:80** Mapping the port **8585** of the host machine to port **80** of the container, it’s the port that apache server use by default, and mapping volumes from datacontainer with **--volumes-from datacontainer**.

**Then you can hit http://host-ip:8585 in your browser** and while you setup your wordpress you should take in considration that in **Database Host** field you have to insert your localhost or host-ip with port **3306** and also you will use the same **user** and **password** that you created while creating **mariadb conainer**.

## Script (  exercici2.sh )
You can run the following script to create a network for the containers and a create datacontainer with this image (ndongelo/centos-httpd-wordpress) which maps the apache directory /var/www/html and mariadb directory /var/lib/mysql and also runs apache and mariadb containers.

#/bin/bash

#Creation of a new network exercici2 .
docker network create exercici2

#Creating a container named datacontainer with the image ndongelo/centos-httpd-wordpress which is mapping volumes /var/www/html for apache and /var/lib/mysql (database for wordpress) for mariadb.
docker create  --name datacontainer -v /var/lib/mysql -v /var/www/html busybox

#Create a mariadb-based container named db with image orboan/dcsss-mariadb using volumes of the datacontainer
docker run  --name=mariadb -p 3309:3309 -d -e MYSQL_ROOT_PASSWORD=mariadb -e MYSQL_DATABASE=db -e MYSQL_USER1=aurelio -e MYSQL_PASSWORD1=aurelio   --network exercici2  --volumes-from datacontainer orboan/dcsss-mariadb

#Create an apache-based container called apache2 with image ndongelo/centos-httpd-php using datacontainer volumes.
docker run  --name=apache1 -p 8585:80 -p 2222:22 -d  --network exercici2  --volumes-from datacontainer ndongelo/centos-httpd-php

## Acknowledgments
The code was inspired by **orboan/dcsss-httpd-wordpress** image.

## Authors
**Author:** NdongElo A.C

