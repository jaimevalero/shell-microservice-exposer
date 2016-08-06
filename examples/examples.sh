 # Stop any running container
 docker stop `docker ps | grep shell-microservice-exposer | awk '{print $1}'`

 # Build 
 docker build -t shell-microservice-exposer .

 # Example of invoke container
 docker run  -p 81:80 shell-microservice-exposer "https://github.com/jaimevalero78/itop-utilities" 

 # Bash inside this container
 docker exec -it `docker ps | grep shell-microservice-exposer | awk '{print $1}'` bash
 # curl -L localhost/cgi-bin/script-name.sh

 # Invoke docker, passing argument as a POST request
 curl -H "Content-Type: application/json" -X POST -d "{ \"arguments\" : [ \"arg1\" , \"arg2\" ] }"  -L 127.0.0.1:80/itop-utilities/synch.sh 
