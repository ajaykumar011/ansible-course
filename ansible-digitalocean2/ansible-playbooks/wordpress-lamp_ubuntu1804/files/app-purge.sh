#!/bin/bash
now=$(date +"%m_%d_%Y")
if [ $USER != "root" ]; then
        echo "Script must be run as user sudo or root "
        exit 1
fi

echo "*******************************************************"
echo "                   WELCOME TO PURGE                    "
echo "*******************************************************"
echo ""
echo "This script only work and tested with ubuntu18 and Debian 10 "
echo "List of Installed appliations:"
systemctl list-unit-files --state=enabled | grep 'apache2\|nginx\|mysql\|php'

echo "Select your App/Service which you want to purge: "
echo "1- Apache2,      2-Nginx    3-MySql     4- Mariadb     5- PHP    6-systeminfo"
echo "Enter your number [1-6]: "
read app
echo "your selection is $app"
sleep 2s

case "$app" in

1)
    echo "Purging Apache2"
    apache2 -v
    apt-get -y purge apache2
    apt-get -y autoremove apache2*
    sudo rm -rf /etc/apache2

    ;;
2)
    echo  "Purging Nginx"
    nginx -v
    sudo apt-get -y remove nginx nginx-common
    sudo apt-get -y autoremove nginx nginx-common
    sudo apt-get -y purge nginx nginx-common
    sudo apt-get -y autoremove
    sudo rm -rf /etc/nginx

    ;;
3)
    echo  "Purging MySQL "
    sudo systemctl stop mysql
    sudo apt-get -y remove --purge mysql*
    sudo apt-get -y purge mysql*
    sudo apt-get -y autoremove
    sudo apt-get -y autoclean
    sudo apt-get -y remove dbconfig-mysql
    sudo apt-get -y remove mysql-server
    sudo mv /var/lib/mysql /var/lib/mysql_old_backup
    sudo mv /etc/mysql /etc/mysql_old_backup
    
    ;;
4)
   echo  "Purging Mariadb"
   apt-get -y purge mariadb*
   apt-get autoremove mariadb* -y

   ;;

5)
   echo  "Purging PHP"
   sudo apt-get purge 'php*' -y
   sudo apt-get autoremove php* -y

   ;;
6)
   echo  "Gathering System information "
   cat /etc/os-release
   service --status-all
   
   ;;

*) echo "you entered a wrong key"
   exit 1
   ;;
esac
