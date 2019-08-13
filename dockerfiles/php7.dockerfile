FROM php:7.1-apache

RUN apt-get update
RUN docker-php-ext-install mysqli pdo_mysql mbstring

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install mcrypt

RUN pecl install xdebug

RUN a2enmod rewrite
RUN rm /var/log/apache2/access.log
