#! /bin/bash

sudo apt -y update
sudo apt -y upgrade

sudo apt -y install apache2
sudo apt -y install mysql-server
sudo apt -y install php libapache2-mod-php php-mysql
sudo apt -y install phpmyadmin

sudo echo "<IfModule mod_dir.c>
    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule>" > /etc/apache2/mods-enabled/dir.conf

sudo systemctl restart apache2

sudo mkdir /var/www/printer
sudo chown -R $USER:$USER /var/www/printer
sudo chmod -R 755 /var/www/printer

sudo echo "<html>
    <head>
        <title>Welcome to printer!</title>
    </head>
    <body>
        <h1>Success!  The printer server block is working and so is the bash script!</h1>
    </body>
</html>" > /var/www/printer/index.html

sudo echo "<VirtualHost *:80>
    ServerAdmin webmaster@haahrs
    ServerName printer
    ServerAlias www.printer
    DocumentRoot /var/www/printer
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/printer.conf

sudo a2ensite printer.conf
sudo a2dissite 000-default.conf
sudo a2dissite 192.168.0.5.conf

sudo ln -s /usr/share/phpmyadmin /var/www/printer

sudo systemctl restart apache2
