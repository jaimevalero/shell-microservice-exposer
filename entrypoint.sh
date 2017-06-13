#! /bin/bash

EXECUTOR_FULL_PATH=/tmp/scripts/shell-microservice-exposer/_executor.sh

Show_Help( )
{

    echo "No arguments supplied. Usage :"
    echo "docker run -p 80:80 -t shell-microservice-exposer jaimevalero78/shell-microservice-exposer <URL_GITHUB_REPO>"
    echo ""
    echo "Where <URL_GITHUB_REPO> is the URL to be exposed as microservices"
    echo `date` `env`

}

Replace_Apache_Script_Path( )
{
    cd /var/www/
    mv cgi-bin ${NAME_GITHUB_REPO}
    sed -i "s/cgi-bin/${NAME_GITHUB_REPO}/g" /etc/httpd/conf/httpd.conf
}

Inject_Repo( )
{
    # Detect BRANCH
    if [ ` echo ${URL_GITHUB_REPO} | grep /tree/  | wc -l ` -eq 1 ] 
    then
       BRANCH_NAME=`basename ${URL_GITHUB_REPO} `
       echo "Detected branch $BRANCH_NAME" 
       NEW_URL_GITHUB_REPO=`echo ${URL_GITHUB_REPO} | sed -e "s@/tree/.*@@g" `
       URL_GITHUB_REPO=$NEW_URL_GITHUB_REPO
       NAME_GITHUB_REPO=`basename ${URL_GITHUB_REPO}`
       mkdir /tmp/scripts/${NAME_GITHUB_REPO}
       echo " git clone -b ${BRANCH_NAME} ${URL_GITHUB_REPO} ANCH_NAME}pts/${NAME_GITHUB_REPO}"
       git clone -b ${BRANCH_NAME} ${URL_GITHUB_REPO} /tmp/scripts/${NAME_GITHUB_REPO}
       RESUL=$?
       #git clone -b feature-test https://github.com/jaimevalero78/test-branching 
    else
       mkdir /tmp/scripts/${NAME_GITHUB_REPO}
       git clone ${URL_GITHUB_REPO} /tmp/scripts/${NAME_GITHUB_REPO}
       RESUL=$?
    fi
    cd /tmp/scripts/${NAME_GITHUB_REPO} 2>/dev/null
    git log -1
    [ $RESUL -ne 0 ] && echo "Error cloning repo  ${URL_GITHUB_REPO}. Exit" && exit 1
    find /tmp/scripts/${NAME_GITHUB_REPO} |  grep -v "\.git"
}

Recreate_Repo_Under_Apache( )
{

    # Recreate directories
    cd /var/www/${NAME_GITHUB_REPO}
    find "/tmp/scripts/${NAME_GITHUB_REPO}" -type d | sed -e "s@/tmp/scripts/${NAME_GITHUB_REPO}/@@" | xargs mkdir -p 2>/dev/null
    for DIR  in ` find /var/www/${NAME_GITHUB_REPO} `
    do
        cp ${EXECUTOR_FULL_PATH} ${DIR}
    done

    for FILE in ` find  /tmp/scripts/${NAME_GITHUB_REPO} -type f | sed -e "s@/tmp/scripts/${NAME_GITHUB_REPO}/@@" | grep -v \.git `
    do
        RELATIVE_PATH=`echo $FILE |sed -e 's@/tmp/scripts/@@'`
        echo "linking $RELATIVE_PATH"
        ln -s ./_executor.sh ${RELATIVE_PATH}
    done

    mkdir /var/www/scripts
    cp -rf /tmp/scripts/${NAME_GITHUB_REPO} /var/www/scripts/
    chmod 777 -R /var/www/
}




# Main
#[ $# -eq 0 ] && Show_Help
[ $# -eq 1 ] && URL_GITHUB_REPO=$1


echo "Entrypoint arguments are $@"
echo "URL_GITHUB_REPO=$URL_GITHUB_REPO="

#URL_GITHUB_REPO=$1
NAME_GITHUB_REPO=`basename ${URL_GITHUB_REPO}`

Inject_Repo

Replace_Apache_Script_Path

Recreate_Repo_Under_Apache

httpd -T -k restart

echo "Webserver started"

while true; do sleep 1000; done

