FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

#COPY ./my.cnf /etc/mysql/my.cnf

RUN service mariadb start \
    && mysql -e "CREATE DATABASE wordpress;" \
    && mysql -e "CREATE USER 'wp_user'@'%' IDENTIFIED BY 'wp_pass';" \
    && mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';" \
    && mysql -e "FLUSH PRIVILEGES;"
    
EXPOSE 3306

CMD ["mysqld_safe"]
