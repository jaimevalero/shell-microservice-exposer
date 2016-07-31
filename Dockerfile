# Test
FROM       centos/httpd
MAINTAINER Jaime Valero <jaimevalero78@yahoo.es>
LABEL      Description="Generic container to receives POST http request to a shell script" Version="0"


# Get git repos
RUN cd /var/www/cgi-bin


# Start scripts
ADD ./scripts/*.sh                /var/www/cgi-bin/ 

# Permissions
RUN chmod -R +x /var/www/cgi-bin/

EXPOSE 80
