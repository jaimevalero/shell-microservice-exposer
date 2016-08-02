#! /bin/bash


Show_Help( )
{

    echo "No arguments supplied. Usage :"
    echo "docker run -p 80:80 -t docker-httpd-inventory jaimevalero78/docker-httpd-inventory <URL_GITHUB_REPO>"
    echo ""
    echo "Where <URL_GITHUB_REPO> is the URL to be exposed as microservices"
}

# Main
[ $# -eq 0 ] && Show_Help
  
echo Arguments are "$@"
