FROM php:7.0.13-fpm-alpine

# install the PHP extensions we need
RUN apk add --update bash sed ssmtp openssl supervisor nginx libpng-dev libjpeg-turbo-dev && rm -rf /var/cache/apk/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mysqli zip \
    && mkdir -p /var/log/supervisor \
    && mkdir -p /etc/nginx/ssl

# wp install environment variables
# see https://wordpress.org/download/release-archive
ENV WP_ROOT /var/www/html
ENV WP_VERSION 4.6.1
ENV WP_SHA1 027e065d30a64720624a7404a1820e6c6fff1202

# upstream tarballs include ./wordpress/ so this gives us /var/www/html/wordpress
RUN curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-${WP_VERSION}.tar.gz \
	&& echo "$WP_SHA1 *wordpress.tar.gz" | sha1sum -c - \
	&& tar -xzf wordpress.tar.gz -C $WP_ROOT \
	&& rm wordpress.tar.gz \
	&& mv $WP_ROOT/wordpress/* . \
	&& rm -rf $WP_ROOT/wordpress \
	&& rm wp-config-sample.php

# copy scripts and config files
COPY nginx/global /etc/nginx/global
COPY nginx/default /etc/nginx/sites-available/default
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY php/php.ini /usr/local/etc/php/php.ini
COPY entrypoint.sh /usr/local/bin/
COPY stop-supervisor.sh /usr/local/bin/
COPY supervisord.conf /etc/supervisord.conf
COPY wp-config.php $WP_ROOT

# update permissions and symlinks
RUN chmod 640 $WP_ROOT/wp-config.php \
		&& chown -R www-data:www-data $WP_ROOT \
    && mkdir -p /etc/nginx/sites-enabled \
    && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/ \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && chown -R www-data:www-data /var/lib/nginx

VOLUME $WP_ROOT

ENTRYPOINT ["entrypoint.sh"]

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]
