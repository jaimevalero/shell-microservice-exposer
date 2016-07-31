# Test
FROM       centos/httpd
MAINTAINER Jaime Valero <jaimevalero78@yahoo.es>
LABEL      Description="" Version=""


# Get git repos
RUN cd /var/www/cgi-bin


# Start scripts
ADD ./scripts/*.sh                /var/www/cgi-bin/ 

# Permissions
RUN chmod -R +x /var/www/cgi-bin/

EXPOSE 80
