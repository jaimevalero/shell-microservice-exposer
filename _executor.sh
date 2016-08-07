#!/bin/bash

tmpfile=$(mktemp abc-script.XXXXXX)

Receive_JSON( )
{
   POST_STRING=$(cat)
   echo "POST_DATA=$POST_STRING"
}

Parse_Arguments( )
{
   INPUT=`echo "$POST_STRING" | jq -c '.|{arguments}[]' | tr -d  [ | tr -d ] | tr ',' ' '`
   echo "ARGUMENTS=$INPUT"
}

Parse_Enviroment_Variables( )
{
   echo "$POST_STRING" | jq -c '.|{environment_variables}[]' | sed 's/","/\
/g' | sed -e 's/":"/=/g' | sed -e 's/{"//g'  | sed -e 's/^/export /g' | sed -e 's/"}//g' > $tmpfile
   echo "Profile contents:"
   cat $tmpfile
   source $tmpfile
   rm -f $tmpfile 2>/dev/null
}


Execute_Script( )
{
   cd /var/www/scripts
   if [ ` echo $INPUT | egrep "^null" | wc -l  ` -eq 1 ]
   then
       echo "Ejecutamos ${SCRIPT_NAME}"
       ./${SCRIPT_NAME}
   else
       echo "Ejecutamos ${SCRIPT_NAME} ${INPUT}"
       ./${SCRIPT_NAME} ${INPUT}
   fi
}

								
#MAIN
echo "Content-type: text/html"
echo ""

Receive_JSON

Parse_Arguments

Parse_Enviroment_Variables

Execute_Script


