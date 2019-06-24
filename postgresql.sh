#!/bin/bash
# -------
# https://www3.ntu.edu.sg/home/ehchua/programming/sql/PostgreSQL_GetStarted.html

echo
echo "--------------------------------------------"
echo "This script will install PostgreSQL."
echo "You may be prompted for sudo password."
echo "--------------------------------------------"
echo

read -e -p "Install PostgreSQL database? [y/n] " -i "n" installpg
if [ "$installpg" = "y" ]; then
  apt -y install postgresql postgresql-contrib && sudo apt-get install libpq-dev -y && sudo systemctl status postgresql
  apt install ufw
  sudo ufw allow 5432/tcp
  echo
  echo "You will now set the default password for the postgres user."
  echo "This will open a psql terminal, enter:"
  echo
  echo "\\password postgres"
  echo
  echo "and follow instructions for setting postgres admin password."
  echo "Press Ctrl+D or type \\q to quit psql terminal"
  echo "START psql --------"
  sudo -u postgres psql postgres
  echo "END psql --------"
  echo
fi

read -e -p "Create Database and user? [y/n] " -i "n" createdb
if [ "$createdb" = "y" ]; then
  read -e -p "Enter the database name:" dbName
  read -e -p "Enter the database user:" dbUser
  sudo -u postgres createuser -D -A -P $dbUser
  echo "Create user $dbUser success"
  sudo -u postgres createdb -O $dbUser $dbName
  echo "Create database $database with owner $dbUser success"
fi


read -e -p "Add the following to pg_hba.conf or postgresql.conf [y/n] " -i "n" following
if [ "$following" = "y" ]; then
  fileconf=/etc/postgresql/*/main/pg_hba.conf
  read -e -p "Enter the database name:" dbName
  read -e -p "Enter the database user:" dbUser
  echo "local    $dbName             $dbUser              0.0.0.0/0              md5" >> $fileconf
  echo "local    $dbName             $dbUser              ::/0                   md5" >> $fileconf
  echo "local    $dbName             $dbUser             127.0.0.1/32            md5" >> $fileconf
  echo "local    $dbName             $dbUser             ::1/128                 md5" >> $fileconf
  sudo service postgresql restart
  echo "Config success"
fi

