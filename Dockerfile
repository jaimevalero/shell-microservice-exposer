# Test
FROM       centos/httpd
MAINTAINER Jaime Valero <jaimevalero78@yahoo.es>
LABEL      Description="Generic container to receives POST http request to a shell script" Version="0"

RUN yum install -y mysql git

# Prepare environment
RUN mkdir -p        /root/scripts/shell-microservice-exposer

ADD .       /root/scripts/shell-microservice-exposer

# Permissions
RUN chmod +x -R     /root/scripts/shell-microservice-exposer/
RUN find  /root/scripts/shell-microservice-exposer/

ENTRYPOINT [",/entrypoint.sh"]
# CMD "/root/scripts/shell-microservice-exposer/entrypoint.sh"

EXPOSE 80
