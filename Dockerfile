FROM debian:buster

WORKDIR /tmp/srcs/

# either "off" or "on"
ARG AUTOINDEX=off

RUN apt-get update && \
	apt-get upgrade -y

RUN apt-get -y install \
	wget \
	apt-utils \
	libnss3-tools \
	nginx \
	mariadb-server \
	php-fpm \
	php-mysql \
	php-cli \
	php-mbstring \
	php-gd \
	php-zip 

COPY srcs/ /tmp/srcs/

RUN rm -rf /var/www/html/

# ssl
RUN chmod 770 mkcert-v1.4.3-linux-amd64 && \
	./mkcert-v1.4.3-linux-amd64 -install && \
	./mkcert-v1.4.3-linux-amd64 localhost && \
	mkdir /etc/nginx/ssl/ && \
	mv localhost.pem /etc/nginx/ssl/ && \
	mv localhost-key.pem /etc/nginx/ssl/ && \
	chmod -R 770 /etc/nginx/ssl/

# nginx
RUN rm -rf /etc/nginx/sites-enabled/* && \
	mv html/* /var/www/ && \
	mv nginx/nginx_${AUTOINDEX}.conf /etc/nginx/sites-available/nginx.conf && \
	ln -fs /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/ && \
	nginx -t

# mysql
RUN bash mysql/setup_mysql.sh

# phpmyadmin
RUN mkdir -p /var/www/phpmyadmin/ && \
	tar xzf phpmyadmin/phpMyAdmin-5.0.4-english.tar.gz --directory /var/www/phpmyadmin/ --strip-components=1 && \
	mv phpmyadmin/index.php /var/www/ && \ 
	mv phpmyadmin/config.inc.php /var/www/phpmyadmin/

# wordpress
RUN mkdir -p /var/www/wordpress/ && \
	tar xzf wordpress/latest.tar.gz --directory /var/www/ && \
	mv wordpress/wp-config.php /var/www/wordpress/

RUN chmod 777 wordpress/wp-cli.phar && \
	mv wordpress/wp-cli.phar /usr/local/bin/wp-cli

# permissions
RUN chown -R $USER:$USER /var/www/ && \
	chmod -R 755 /var/www/

RUN mv start.sh /root/ && \
	chmod 770 /root/start.sh

RUN rm -rf /tmp/srcs/
EXPOSE 80 443

CMD service mysql start && service php7.3-fpm start && wp-cli cli update && nginx -g 'daemon off;'
