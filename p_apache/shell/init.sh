#!/bin/bash

sudo yum update -y
sudo yum install http -y
sudo yum install httpd-devel -y
sudo yum install mysql mysql-server mysql-devel -y

sudo mv /tmp/index.html /var/www/html/index.html