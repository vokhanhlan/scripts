#!/bin/bash
adduser deloy
usermod -aG sudo deloy
rsync --archive --chown=deloy:deloy ~/.ssh /home/deloy


chmod -R g+w /var/www/folder
