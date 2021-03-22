#!/bin/bash

service mysql start
echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -u root
echo "CREATE USER 'root'@'localhost';" | mysql -u root
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('defenatlynotasecurityrisk');" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' IDENTIFIED BY 'defenatlynotasecurityrisk';" | mysql -u root

echo "FLUSH PRIVILEGES;" | mysql -u root
# ?