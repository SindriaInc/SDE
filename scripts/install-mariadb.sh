#!/bin/sh

# Check If MariaDB Has Been Installed

if [ -f /home/vagrant/.mariadb ]
then
    echo "MariaDB already installed."
    exit 0
fi

touch /home/vagrant/.mariadb

cp /var/www/$1/scripts/templates/MariaDB.repo /etc/yum.repos.d/
sudo yum install MariaDB-server MariaDB-client -y
sudo systemctl start mariadb


# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('secret') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

# Create sindria schema
mysql --user="root" --password="secret" -e "CREATE database sindria;"

# Create sindria user on DB
mysql --user="root" --password="secret" -e "CREATE USER 'sindria'@'0.0.0.0' IDENTIFIED BY 'secret';"
mysql --user="root" --password="secret" -e "GRANT ALL ON *.* TO 'sindria'@'0.0.0.0' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
mysql --user="root" --password="secret" -e "GRANT ALL ON *.* TO 'sindria'@'%' IDENTIFIED BY 'secret' WITH GRANT OPTION;"
mysql --user="root" --password="secret" -e "FLUSH PRIVILEGES;"