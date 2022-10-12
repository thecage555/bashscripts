#! /bin/bash

sudo apt -y update
sudo apt -y upgrade

sudo apt -y install apache2
sudo apt -y install mysql
sudo apt -y install mysql-server
sudo apt -y install php libapache2-mod-php php-mysql
sudo apt -y install phpmyadmin

sudo echo "<IfModule mod_dir.c>
    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule>" > /etc/apache2/mods-enabled/dir.conf

sudo systemctl restart apache2

sudo chown -R www-data:www-data /var/www/192.168.0.5
sudo chmod -R 755 /var/www/192.168.0.5
sudo chmod -R g+w /var/www/192.168.0.5
sudo usermod -a -G www-data $USER
#adding user to correct group www-data

sudo echo "<html>
    <head>
        <title>Welcome to printer!</title>
    </head>
    <body>
        <h1>Success!  The printer server block is working and so is the bash script!</h1>
    </body>
</html>" > /var/www/192.168.0.5/index.html

sudo echo "<VirtualHost *:80>
    ServerAdmin webmaster@haahrs
    ServerName 192.168.0.5
    ServerAlias www.192.168.0.5/
    DocumentRoot /var/www/192.168.0.5
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/192.168.0.5.conf

sudo a2ensite 192.168.0.5.conf
sudo a2dissite 000-default.conf


sudo ln -s /usr/share/phpmyadmin /var/www/192.168.0.5

sudo systemctl restart apache2

echo "you may need to run the script again after adding php files/folders or use usermod -a -G www-data $USER again"
