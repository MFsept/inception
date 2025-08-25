FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./index.html /var/www/html/index.html
COPY ./certs/ /etc/nginx/certs

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
