# shell-microservice-exposer
Expose your own scripts as a cool microservice API dockerizing it.

Usage:

docker build -t shell-microservice-exposer .

## Example of invoke container
docker run  -p 80:80 shell-microservice-exposer "https://github.com/jaimevalero78/itop-utilities"

## Then, invoke the scripts
curl -L 127.0.0.1:80/itop-utilities/synch.sh

