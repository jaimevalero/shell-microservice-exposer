

o "Content-type: text/html"
echo ""
POST_STRING=$(cat). 
echo "POST_STRING=$POST_STRING"
env
INPUT=`echo "$POST_STRING | jq -c '.|{arguments}[]' | tr -d  [ | tr -d ] | tr ',' ' '`
echo INPUT=$INPUT

cd /var/www/scripts
 ./${SCRIPT_NAME} "$INPUT"



