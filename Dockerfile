# Test
FROM       centos/httpd
MAINTAINER Jaime Valero <jaimevalero78@yahoo.es>
LABEL      Description="Generic container to receives POST http request to a shell script" Version="0"

RUN yum install -y mysql git

# Prepare environment
RUN mkdir /root/scripts/
RUN cd /root/scripts/

# Get git repos
RUN git clone "http://github.com/jaimevalero78/docker-httpd-inventory" /root/scripts/docker-httpd-inventory
RUN cd /root/scripts/docker-httpd-inventory

# Permissions
RUN chmod +x -R     /root/scripts/docker-httpd-inventory/

ENTRYPOINT ["/root/scripts/docker-httpd-inventory//entrypoint.sh"]

EXPOSE 80
