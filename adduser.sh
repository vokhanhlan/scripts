#!/bin/bash
adduser deploy
usermod -aG sudo deploy
rsync --archive --chown=deploy:deploy ~/.ssh /home/deploy


chmod -R g+w /var/www/folder
