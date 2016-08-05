 # Stop any running container
 docker stop `docker ps | grep shell-microservice-exposer | awk '{print $1}'`

 # Build 
 docker build -t shell-microservice-exposer .

 # Example of invoke container
 docker run  -p 81:80 shell-microservice-exposer "https://github.com/jaimevalero78/itop-utilities" 

 # Bash inside this container
 docker exec -it `docker ps | grep shell-microservice-exposer | awk '{print $1}'` bash
 # curl -L localhost/cgi-bin/script-name.sh

