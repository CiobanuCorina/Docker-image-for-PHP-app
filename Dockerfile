FROM ubuntu:20.04

RUN apt-get update

RUN apt-get update && apt-get install -y software-properties-common
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update && apt-get install -y --no-install-recommends \
    php5.6-fpm \
    mysql-server \
    php5.6-mysql \
    nginx

COPY ./my.cnf /etc/mysql/
RUN usermod -d /var/lib/mysql/ mysql

WORKDIR /var/www/app
EXPOSE 80/

COPY . .
RUN echo "cgy.fix_pathinfo=0" >> /etc/php/5.6/fpm/php.ini
COPY ./default /etc/nginx/sites-available/default
ADD ./nginx.conf /etc/nginx/conf.d/app.conf
COPY ./commands.sh /scripts/commands.sh
RUN ["chmod", "+x", "/scripts/commands.sh"]
ENTRYPOINT ["/scripts/commands.sh"]

