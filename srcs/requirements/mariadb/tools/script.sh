#!/bin/bash

service mysql start

echo "CREATE DATABASE IF NOT EXISTS $db_name ;" > db.sql
echo "CREATE USER '$db_user'@'%' IDENTIFIED BY '$mysql_password' ;" >> db.sql
echo "GRANT ALL PRIVILEGES ON $db_name.* TO $db_user'@'%' ;" >> db.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db.sql
echo "FLUSH PRIVILEGES;" >> db.sql

mysql < db.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld