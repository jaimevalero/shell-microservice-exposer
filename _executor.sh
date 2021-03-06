#!/bin/bash

tmpfile=$(mktemp abc-script.XXXXXX)
DEBUG=0

ShowLog( )
{
   [ $DEBUG -ne 0 ] && echo [`basename $0`] [`date +'%Y_%m_%d %H:%M:%S'`] [$$] [${FUNCNAME[1]}] $@
}
 
Receive_JSON( )
{
   POST_STRING=$(cat)
   ShowLog "POST_DATA=$POST_STRING"
}

Parse_Arguments( )
{
   INPUT=`echo "$POST_STRING" | jq -c '.|{arguments}[]' | tr -d  [ | tr -d ] | tr ',' ' '`
   ShowLog "ARGUMENTS=$INPUT"
}

Parse_Enviroment_Variables( )
{
   echo "$POST_STRING" | jq -c '.|{environment_variables}[]' | sed 's/","/\
/g' | sed -e 's/":"/=\"/g' | sed -e 's/{"//g'  | sed -e 's/^/export /g' | sed -e 's/"}/\"/g' > $tmpfile
   ShowLog "Profile contents:"
   ShowLog `cat $tmpfile `
   source $tmpfile
   rm -f $tmpfile 2>/dev/null
}


Execute_Script( )
{
 FULL_PATH=/var/www/scripts${SCRIPT_NAME}
 cd ` dirname $FULL_PATH` 2>/dev/null
 SCRIPT_SHORT_NAME=` basename $FULL_PATH`
 if [ ` echo $INPUT | egrep "^null" | wc -l  ` -eq 1 ]
 then
     ShowLog "Ejecutamos ${SCRIPT_SHORT_NAME} en `dirname $FULL_PATH`"
     ./${SCRIPT_SHORT_NAME}
 else
     ShowLog "Ejecutamos ${SCRIPT_SHORT_NAME} ${INPUT}"
    ./${SCRIPT_SHORT_NAME} ${INPUT}
 fi
}

								
#MAIN
#echo "Content-type: text/html"
echo ""

Receive_JSON

Parse_Arguments

Parse_Enviroment_Variables

Execute_Script

