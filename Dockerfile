# Test
FROM       centos/httpd
MAINTAINER Jaime Valero <jaimevalero78@yahoo.es>
LABEL      Description="Generic container to receives POST http request to a shell script" Version="0"

RUN yum install -y mysql

# Prepare environment
RUN cd    /var/www/cgi-bin
RUN mkdir /root/scripts/
RUN cd    /root/scripts/
# Get git repos
RUN git clone https://github.com/jaimevalero78/docker-httpd-inventory
RUN cd  /root/scripts/docker-httpd-inventory


# Permissions
RUN chmod +x      /root/scripts/docker-httpd-inventory/*sh
RUN chmod -R +x   /var/www/cgi-bin/

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 80
