FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl curl netcat-openbsd && rm -rf /var/lib/apt/lists/*

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./certs/ /etc/nginx/certs
COPY ./waiting_for_linking.sh /waiting_for_linking.sh
RUN chmod +x /waiting_for_linking.sh

EXPOSE 443

CMD ["/waiting_for_linking.sh"]