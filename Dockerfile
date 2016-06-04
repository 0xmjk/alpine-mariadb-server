FROM alpine:3.4
RUN apk update && apk add bash mariadb mariadb-client
RUN install -o mysql -g mysql -d -m 755 /run/mysqld
ADD start.sh /
EXPOSE 3306
ENTRYPOINT ["/start.sh"]

