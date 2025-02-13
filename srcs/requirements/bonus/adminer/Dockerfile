FROM debian:bullseye

RUN apt update -y && apt install wget -y && apt install php php-mysql -y

COPY ./tools/script.sh /

CMD ["/script.sh"]