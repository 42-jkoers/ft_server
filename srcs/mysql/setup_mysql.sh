#!/bin/bash

service mysql start
echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -u root
echo "CREATE USER 'joppe'@'localhost';" | mysql -u root
echo "SET PASSWORD FOR 'joppe'@'localhost' = PASSWORD('definitelynotasecurityrisk');" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'joppe'@'localhost' IDENTIFIED BY 'definitelynotasecurityrisk';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
mysql wordpress -u root < /tmp/srcs/mysql/wordpress.sql
# ?