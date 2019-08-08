# Stage 1: Install dependencies
FROM composer:1.7 as vendor

WORKDIR /app
COPY composer.json composer.json
COPY composer.lock composer.lock
RUN mkdir -p database/seeds && mkdir -p database/factories
RUN composer global require hirak/prestissimo

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

# Stage 2: Serve the app
FROM php:7.3-apache

RUN apt-get update -q \
    && apt-get install -y -q libmcrypt-dev libmagickwand-dev git zip unzip --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN pecl -q install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install pdo_mysql > /dev/null

# Install composer
ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

# Install PHP_CodeSniffer
RUN composer global require "squizlabs/php_codesniffer=*"

# Setup working directory
WORKDIR /var/www

COPY . /var/www

# Copy the vendors from Stage 1
COPY --from=vendor /app/vendor/ /var/www/vendor/

RUN composer install --prefer-dist

ENV APACHE_DOCUMENT_ROOT /var/www/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
