#!/bin/bash
adduser deloy
usermod -aG sudo deloy
rsync --archive --chown=deloy:deloy ~/.ssh /home/deloy
