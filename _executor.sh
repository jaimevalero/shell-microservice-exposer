#!/bin/bash

tmpfile=$(mktemp /abc-script.XXXXXX)

Receive_JSON( )
{
   POST_STRING=$(cat)
   echo "POST_STRING=$POST_STRING"
}

Parse_Arguments( )
{
   INPUT=`echo "$POST_STRING" | jq -c '.|{arguments}[]' | tr -d  [ | tr -d ] | tr ',' ' '`
   echo ARGUMENTS=$INPUT
}

Parse_Enviroment_Variables( )
{
   echo "$POST_STRING" | jq -c '.|{enviroment_variables}[]' | sed 's/","/\
   /g' | sed -e 's/":"/=/g' | sed -e 's/{"//g' | sed -e 's/"}//g' | sed -e 's/^/export /g' > $tmpfile
   cat $tmpfile
   source $tmpfile
   rm -f $tmpfile 2>/dev/null
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

Receive_JSON

Parse_Arguments

Parse_Enviroment_Variables

Execute_Script


