FROM php:7.4-fpm

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y \
  gzip \
  libbz2-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libpng-dev \
  libsodium-dev \
  libssh2-1-dev \
  libxslt1-dev \
  libzip-dev \
  lsof \
  default-mysql-client \
  zip

RUN docker-php-ext-configure \
  gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/

RUN docker-php-ext-install \
  bcmath \
  bz2 \
  calendar \
  exif \
  gd \
  gettext \
  intl \
  mysqli \
  opcache \
  pcntl \
  pdo \
  pdo_mysql \
  soap \
  sockets \
  sodium \
  sysvmsg \
  sysvsem \
  sysvshm \
  xsl \
  zip

COPY php.ini /usr/local/etc/php/

RUN groupadd -g 1000 app \
  && useradd -g 1000 -u 1000 -d /var/www -s /bin/bash app
RUN mkdir -p /var/www/html \
  && chown -R app:app /var/www


USER app:app
VOLUME /var/www
WORKDIR /var/www/html
