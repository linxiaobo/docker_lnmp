#!/bin/bash

sudo pkill mysqld
#sudo service mysql stop
sudo service apache2 stop

#docker-compose -f docker/docker-compose.yml up -d
docker-compose up -d
