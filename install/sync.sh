#!/bin/bash

# import variables from .env file
. ./.env

PARAM=""

if [ -n "$1" ]; then
  PARAM=$1
fi

echo -e "${BBLACK}"
echo "Synchronizing working directory"

[ ! -d ./wordpress/wp-content/plugins/neuralseo ] && mkdir -p ./wordpress/wp-content/plugins/neuralseo
[ ! -d ./wordpress/wp-content/plugins/neuralseo/vendor ] && mkdir -p ./wordpress/wp-content/plugins/neuralseo/vendor
rsync -cav"${PARAM}" --delete ./neuralseo/app/ ./wordpress/wp-content/plugins/neuralseo/
rsync -cav"${PARAM}" --delete ./neuralseo/vendor/ ./wordpress/wp-content/plugins/neuralseo/vendor/

echo "Done"
echo -e "${COLOR_OFF}"
