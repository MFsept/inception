FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php8.2-fpm php8.2-mysql php8.2-cli php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml php8.2-zip \
    wget unzip mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN rm -f /run/php/php8.2-fpm.sock

RUN mkdir -p /var/www/wordpress

WORKDIR /var/www/wordpress

COPY ./wp-config.php /var/www/wordpress/wp-config.php
COPY www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz

RUN chown -R www-data:www-data /var/www/wordpress \
    && chmod -R 755 /var/www/wordpress

EXPOSE 9000

CMD ["php-fpm8.2", "-F"]



