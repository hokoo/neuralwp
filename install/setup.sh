#!/bin/bash

# run from project root directory
bash ./install/setup-env.sh

# import variables from .env file
. ./.env

echo "Containers creating..."
docker-compose -p neuralwp up -d
echo "Containers created."

echo -e "Composer installation..."
docker-compose -p neuralwp exec php sh -c "composer install"
echo -e "Plugin composer installation..."
docker-compose -p neuralwp exec php sh -c "cd ./neuralseo && composer install"

echo "WP setup preparing..."
# prepare file structure

# Now we have to clone plugin into WP plugins directory
make sync q

[ ! -f ./index.php ] && echo "<?php
define( 'WP_USE_THEMES', true );
require( './wordpress/wp-blog-header.php' );" > index.php

if [ ! -f wp-config.php ]; then
  WPCONFIG=$(< ./install/.example/wp-config.php.template)
  printf "$WPCONFIG" $DB_NAME $DB_USER $DB_PASSWORD $DB_HOST > ./wp-config.php
fi

# install WP
echo "WP database init"
echo -e -n "${ICYAN}Would you init new instance (y), or do nothing (n)? ${RYELLOW}(y/n)${COLOR_OFF}"

read -r item
case "$item" in
    y|Y)
    echo "WP database init new instance..."
    docker-compose -p neuralwp exec php sh -c "wp db reset --yes && wp core install --url=$PROJECT_BASE_URL --title=\"$WP_TITLE\" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email"
    docker-compose -p neuralwp exec php sh -c "wp plugin delete akismet hello"
    docker-compose -p neuralwp exec php sh -c "wp plugin activate --all"
    printf "WP User Admin: ${RYELLOW}%s \n${COLOR_OFF}WP User Pass: ${RYELLOW}%s${COLOR_OFF}\n" $WP_ADMIN $WP_ADMIN_PASS
      ;;

    *)
      echo "WP database has not been touched."
      ;;
esac

echo -e "${ICYAN}Do not forget update the hosts file with line:"
echo -e "${BIGREEN}127.0.0.1 ${PROJECT_BASE_URL}${COLOR_OFF}"
echo "Done."
