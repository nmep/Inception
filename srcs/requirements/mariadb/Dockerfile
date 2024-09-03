FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install mariadb-server -y 

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod u+x /usr/local/bin/mariadb.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]
