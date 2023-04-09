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
rsync -cav"${PARAM}" --delete ./neuralseo/app/ ./wordpress/wp-content/plugins/neuralseo/

echo "Done"
echo -e "${COLOR_OFF}"
