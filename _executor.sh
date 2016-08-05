#!/bin/bash

echo "Content-type: text/html"
echo ""

env
#jq -c '.|{arguments}[]' | tr -d  [ | tr -d ] | tr ',' ' '

cd /var/www/scripts
 ./${SCRIPT_NAME}



