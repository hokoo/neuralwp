#!/bin/bash

# import variables from .env file
. ./.env

cd ./cf7-telegram/vendor/hokoo || exit 1
rm -rf ./wpconnections/
git clone git@github.com:hokoo/wpConnections.git wpconnections
cd ./wpconnections || exit 1
git pull origin
git checkout dev
cd ../../../../
docker-compose -p cf7tg exec php sh -c "cd ./cf7-telegram/vendor/hokoo/wpconnections && composer install"
