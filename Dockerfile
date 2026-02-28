FROM php:8.4-apache

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip pdo_mysql 

RUN a2enmod rewrite

COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html  
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache  
RUN chown -R 777 /var/www/html/storage /var/www/html/bootstrap/cache



