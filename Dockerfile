# Test
FROM       centos/httpd
MAINTAINER Jaime Valero <jaimevalero78@yahoo.es>
LABEL      Description="Generic container to receives POST http request to a shell script" Version="0"

RUN yum install -y mysql git

# Prepare environment
RUN mkdir /root/scripts/
RUN cd /root/scripts/

# Get git repos
RUN git clone "http://github.com/jaimevalero78/shell-microservice-exposer" /root/scripts/shell-microservice-exposer
RUN cd /root/scripts/shell-microservice-exposer

# Permissions
RUN chmod +x -R     /root/scripts/shell-microservice-exposer/

ENTRYPOINT ["/root/scripts/shell-microservice-exposer//entrypoint.sh"]

EXPOSE 80
