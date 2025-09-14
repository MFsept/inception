FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    curl ca-certificates \
    php8.2-fpm php8.2-mysql php8.2-cli php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml php8.2-zip \
    wget unzip mariadb-client \
    && rm -rf /var/lib/apt/lists/* \
    # Install WP-CLI
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN rm -f /run/php/php8.2-fpm.sock

RUN mkdir -p /var/www/wordpress

WORKDIR /var/www/wordpress

COPY ./wp-config.php /var/www/wordpress/wp-config.php
COPY www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY init_wp.sh /usr/local/bin/init_wp.sh

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz

RUN chown -R www-data:www-data /var/www/wordpress \
    && chmod -R 755 /var/www/wordpress

RUN chmod +x /usr/local/bin/init_wp.sh

EXPOSE 9000

# CMD ["php-fpm8.2", "-F"]

#CMD ["/bin/bash", "-c", "/usr/local/bin/init_wp.sh && php-fpm8.2 -F"]

COPY init_wp_site.sh /usr/local/bin/init_wp_site.sh
RUN chmod +x /usr/local/bin/init_wp_site.sh

CMD bash -c "/usr/local/bin/init_wp.sh & sleep 5 && /usr/local/bin/init_wp_site.sh && fg"



