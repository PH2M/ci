FROM php:8.1-cli

MAINTAINER PH2M <contact@ph2m.com>

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxslt1-dev \
    sendmail-bin \
    sendmail \
    sudo \
    cron \
    rsyslog \
    default-mysql-client \
    git \
    libzip-dev \
    libonig-dev

# Configure the gd library
RUN docker-php-ext-configure \
  gd --with-freetype --with-jpeg

# Install required PHP extensions
RUN docker-php-ext-install \
  dom \
  gd \
  intl \
  pdo_mysql \
  xsl \
  zip \
  soap \
  bcmath \
  calendar \
  sockets \
  pcntl


RUN docker-php-ext-configure \
    calendar

ENV PHP_MEMORY_LIMIT 2G

VOLUME /root/.composer/cache

# Get composer installed to /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --version=2.5.1 --install-dir=/usr/local/bin --filename=composer

RUN curl -LO https://deployer.org/deployer.phar && chmod +x ./deployer.phar && mv ./deployer.phar /usr/local/bin/dep
RUN ["chmod", "+x", "/usr/local/bin/dep"]

CMD ["bash"]
