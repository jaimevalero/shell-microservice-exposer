# shell-microservice-exposer
Expose your own scripts as a cool microservice API dockerizing it.

Usage:

docker build -t shell-microservice-exposer .

## Example of invoke container
docker run  -p 80:80 jaimevalero78/shell-microservice-exposer "https://github.com/jaimevalero78/itop-utilities"

## Then, invoke the scripts
curl -L 127.0.0.1:80/itop-utilities/synch.sh

### Invoke a script passing arguments
curl -H "Content-Type: application/json" -X POST  -d "{ \"arguments\" : [ \"arg1\" , \"arg2\" ] }" -L   127.0.0.1:80/itop-utilities/synch.sh

### Invoke a script passing environment variables
curl -H "Content-Type: application/json" -X POST   -d "{\"environment_variables\":{\"MYSQL_USER\":\"root\",\"MYSQL_PASSWORD\":\"PASSWORD\",\"MYSQL_HOST\":\"myserver\"}}"   -L  127.0.0.1:80/itop-utilities/synch.sh

### Invoke a script passing both arguments and environment variables
curl -H "Content-Type: application/json"  -X POST -d "{\"environment_variables\":{\"MYSQL_USER\":\"root\",\"MYSQL_PASSWORD\":\"PASSWORD\",\"MYSQL_HOST\":\"myserver\"},\"arguments\":[\"ARG1\",\"ARG2\",\"ARG3\"]}"\  -L  127.0.0.1:80/itop-utilities/synch.sh


