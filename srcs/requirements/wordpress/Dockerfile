FROM debian:bookworm

# Installer PHP et extensions nécessaires pour WordPress + outils
RUN apt-get update && apt-get install -y \
    php-fpm php-mysql php-cli php-curl php-gd php-mbstring php-xml php-zip \
    wget unzip mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Créer le dossier pour WordPress
RUN mkdir -p /var/www/wordpress

WORKDIR /var/www/wordpress

# Télécharger et extraire WordPress
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz

# Permissions
RUN chown -R www-data:www-data /var/www/wordpress \
    && chmod -R 755 /var/www/wordpress

# Exposer le port de PHP-FPM
EXPOSE 9000

# Lancer PHP-FPM en mode foreground
CMD ["php-fpm", "-F"]


