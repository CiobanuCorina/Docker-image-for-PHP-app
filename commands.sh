#! /bin/bash

service php5.6-fpm start
service mysql start
user='root'
server='localhost'
password='mysql'
mysql -u root --execute="ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'mysql'; CREATE DATABASE todoit; USE todoit; source /var/www/app/todoit.sql;";
service nginx start
while true; do sleep 1; done