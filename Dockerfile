FROM php:7.3-fpm-alpine

RUN apk update && \
        apk add --no-cache git zip curl freetype libpng libjpeg-turbo zlib libzi                                                                                                                                  p postgresql && \

        apk add --no-cache libxml2-dev curl-dev freetype-dev libpng-dev libjpeg-                                                                                                                                  turbo-dev zlib-dev libzip-dev postgresql-dev && \

        docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
        NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \

        docker-php-ext-install -j$(nproc) mbstring tokenizer ctype json bcmath x                                                                                                                                  ml zip gd pdo pdo_mysql pdo_pgsql mysqli pgsql curl iconv session && \

        curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/l                                                                                                                                  ocal/bin --filename=composer && \

        apk del libxml2-dev curl-dev freetype-dev libpng-dev libjpeg-turbo-dev z                                                                                                                                  lib-dev libzip-dev postgresql-dev

RUN chmod -R 755 /var/www/app

WORKDIR /var/www/app

ENTRYPOINT ["docker-php-entrypoint"]
##<autogenerated>##
CMD ["php", "-a"]
##</autogenerated>##
