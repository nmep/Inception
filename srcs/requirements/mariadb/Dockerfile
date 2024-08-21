From debian:bullseye

RUN apt update -y && apt upgrade -y

RUN apt-get install mariadb-server -y 

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.conf

COPY tools/mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod u+x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]