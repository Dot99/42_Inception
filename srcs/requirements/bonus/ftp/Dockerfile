FROM debian:bullseye

RUN apt-update -y && apt install vsftpd -y

COPY ./tools/script.sh /

CMD ["/script.sh"]