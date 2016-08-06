#!/bin/bash

Receive_Arguments( )
{
   POST_STRING=$(cat)
   echo "POST_STRING=$POST_STRING"
}

Parse_Arguments( )
{
   INPUT=`echo "$POST_STRING" | jq -c '.|{arguments}[]' | tr -d  [ | tr -d ] | tr ',' ' '`
   echo INPUT=$INPUT
}

Execute_Script( )
{
   cd /var/www/scripts
   echo "Ejecutamos ${SCRIPT_NAME} ${INPUT}"
   ./${SCRIPT_NAME} ${INPUT}

}

#MAIN
echo "Content-type: text/html"
echo ""

Receive_Arguments

Parse_Arguments

Execute_Script


