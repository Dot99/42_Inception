FROM debian:bullseye

EXPOSE 3306

RUN apt update -y  && apt --no-install-recommends --no-install-suggests install mariadb-server -y &&\
	rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d

COPY tools/script.sh /bin

RUN chmod +x /bin/script.sh

CMD ["script.sh", "mysqld_safe"]