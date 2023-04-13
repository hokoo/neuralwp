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
rsync -av"${PARAM}" --delete ./neuralseo/ ./wordpress/wp-content/plugins/neuralseo/

echo "Done"
echo -e "${COLOR_OFF}"
