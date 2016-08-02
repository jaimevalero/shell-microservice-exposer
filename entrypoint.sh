#! /bin/bash

EXECUTOR_FULL_PATH=/root/scripts/shell-microservice-exposer/executor.sh

Show_Help( )
{

    echo "No arguments supplied. Usage :"
    echo "docker run -p 80:80 -t shell-microservice-exposer jaimevalero78/shell-microservice-exposer <URL_GITHUB_REPO>"
    echo ""
    echo "Where <URL_GITHUB_REPO> is the URL to be exposed as microservices"
}

# Main
[ $# -eq 0 ] && Show_Help

echo Arguments are "$@"
URL_GITHUB_REPO=$1
NAME_GITHUB_REPO=`basename ${URL_GITHUB_REPO}`


git clone ${URL_GITHUB_REPO} /root/scripts/${NAME_GITHUB_REPO}

# Recreate directories
cd /var/www/cgi/bin
find -type d ${NAME_GITHUB_REPO} | sed -e 's@/root/scripts/@@' | xargs mkdir -p
for FILE in `find -type f ${NAME_GITHUB_REPO} `
do
  RELATIVE_PATH=`echo $FILE |sed -e 's@/root/scripts/@@'`
  echo "linking $RELATIVE_PATH"
  ln -s $RELATIVE_PATH $EXECUTOR_FULL_PATH

done
