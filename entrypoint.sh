#! /bin/bash

EXECUTOR_FULL_PATH=/root/scripts/shell-microservice-exposer/_executor.sh

Show_Help( )
{

    echo "No arguments supplied. Usage :"
    echo "docker run -p 80:80 -t shell-microservice-exposer jaimevalero78/shell-microservice-exposer <URL_GITHUB_REPO>"
    echo ""
    echo "Where <URL_GITHUB_REPO> is the URL to be exposed as microservices"
}

Replace_Apache_Script_Path( )
{
    cd /var/www/
    mv cgi-bin ${NAME_GITHUB_REPO}
    sed -i "s/cgi-bin/${NAME_GITHUB_REPO}/g" /etc/httpd/conf/httpd.conf
    httpd -k graceful

}

Inject_Repo( )
{
    mkdir /root/scripts/${NAME_GITHUB_REPO}
    git clone ${URL_GITHUB_REPO} /root/scripts/${NAME_GITHUB_REPO}
    RESUL=$?
    [ $RESUL -ne 0 ] && echo "Error cloning repo  ${URL_GITHUB_REPO}. Exit" && exit 1
    find /root/scripts/${NAME_GITHUB_REPO} |  grep -v "\.git"
}


# Main
[ $# -eq 0 ] && Show_Help

echo "Entrypoint arguments are $@"
URL_GITHUB_REPO=$1
NAME_GITHUB_REPO=`basename ${URL_GITHUB_REPO}`

Replace_Apache_Script_Path

Inject_Repo


# Recreate directories
cd /var/www/${NAME_GITHUB_REPO}
find "/root/scripts/${NAME_GITHUB_REPO}" -type d | sed -e "s@/root/scripts/${NAME_GITHUB_REPO}/@@" | xargs mkdir -p 2>/dev/null


for FILE in `find  /root/scripts/${NAME_GITHUB_REPO} -type f | sed -e "s@/root/scripts/${NAME_GITHUB_REPO}/@@" | grep -v \.git `
do
  RELATIVE_PATH=`echo $FILE |sed -e 's@/root/scripts/@@'`
  echo "linking $RELATIVE_PATH"
  ln -s ./_executor.sh ${RELATIVE_PATH}
done

httpd
echo "Started http"

while true; do sleep 1000; done
