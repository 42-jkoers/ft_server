FROM debian:buster

WORKDIR /tmp/srcs/

RUN apt-get update && \
	apt-get upgrade -y

RUN apt-get -y install \
	wget \
	apt-utils \
	libnss3-tools \
	nginx
	# mariadb-server \
	# php-fpm \
	# php-mysql \
	# php-cli \
	# php-mbstring \
	# php-gd \
	# php-zip 

COPY srcs/ /tmp/srcs/

RUN chmod 774 mkcert-v1.4.3-linux-amd64 && \
	./mkcert-v1.4.3-linux-amd64 -install && \
	./mkcert-v1.4.3-linux-amd64 localhost && \
	mkdir /etc/nginx/ssl/ && \
	mv localhost.pem /etc/nginx/ssl/ && \
	mv localhost-key.pem /etc/nginx/ssl/ && \
	chmod -R 774 /etc/nginx/ssl/

RUN rm -rf /etc/nginx/sites-enabled/* && \
	rm -rf /var/www/html/* && \
	mv html/* /var/www/html/ && \
	mv nginx.conf /etc/nginx/sites-available/ && \
	ln -fs /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/ && \
	nginx -t

RUN mkdir /var/www/html/phpmyadmin/ && \
	tar xzfv phpMyAdmin-5.0.4-english.tar.gz && \
	cp -r phpMyAdmin-5.0.4-english/. /var/www/html/phpmyadmin/

RUN rm -rf /tmp/srcs/

EXPOSE 80 443

# CMD service mysql restart && service php7.3-fpm start && nginx -g 'daemon off;'
CMD nginx -g 'daemon off;'

# RUN chown -R www-data:www-data /var/www/* && chmod -R 755 /var/www/*
