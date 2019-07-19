FROM php:7.2.11-apache-stretch

# ENV COMPOSER_ALLOW_SUPERUSER 1
# ENV COMPOSER_HOME /tmp
# ENV COMPOSER_VERSION 1.7.1

RUN a2enmod rewrite

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Override with custom opcache settings
# COPY config/opcache.ini $PHP_INI_DIR/conf.d/

# Set default values for PHP configuration
RUN echo "memory_limit=2048M" > "$PHP_INI_DIR/conf.d/memory-limit.ini"
RUN echo "opcache.enable=1" > "$PHP_INI_DIR/conf.d/memory-limit.ini"

# RUN pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug
# RUN echo 'zend_extension="/usr/local/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so"' >> /usr/local/etc/php/php.ini
# RUN echo 'xdebug.remote_port=9000' >> /usr/local/etc/php/php.ini
# RUN echo 'xdebug.remote_enable=1' >> /usr/local/etc/php/php.ini
# RUN echo 'xdebug.remote_connect_back=1' >> /usr/local/etc/php/php.ini

# RUN curl --silent --fail --location --retry 3 --output /tmp/installer.php --url https://raw.githubusercontent.com/composer/getcomposer.org/b107d959a5924af895807021fcef4ffec5a76aa9/web/installer \
#  && php -r " \
#     \$signature = '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061'; \
#     \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
#     if (!hash_equals(\$signature, \$hash)) { \
#         unlink('/tmp/installer.php'); \
#         echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
#         exit(1); \
#     }" \
#  && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
#  && composer --ansi --version --no-interaction

    # && echo "date.timezone=${PHP_TIMEZONE:-UTC}" > "$PHP_INI_DIR/conf.d/date_timezone.ini"

# ENV COMPOSER_ALLOW_SUPERUSER 1
# ENV COMPOSER_HOME /tmp
# ENV COMPOSER_VERSION 1.7.3

# RUN curl --silent --fail --location --retry 3 --output /tmp/installer.php --url https://raw.githubusercontent.com/composer/getcomposer.org/b107d959a5924af895807021fcef4ffec5a76aa9/web/installer \
#     && php -r " \
#     \$signature = '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061'; \
#     \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
#     if (!hash_equals(\$signature, \$hash)) { \
#     unlink('/tmp/installer.php'); \
#     echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
#     exit(1); \
#     }" \
#     && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
#     && composer --ansi --version --no-interaction \
#     && rm -f /tmp/installer.php

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxml2-dev \
        libmcrypt-dev \
        libreadline-dev \
        libxslt-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install -j$(nproc) \
  dom \
  gd \
  intl \
  mbstring \
  pdo_mysql \
  xsl \
  zip \
  soap \
  bcmath \
  iconv \
  opcache
