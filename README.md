# MariaDB 10.1 Docker Image (based on Alpine 3.4)

This is a MariaDB 10.1 Docker image built on top of official [alpine:3.4](https://hub.docker.com/_/alpine/) image.

Note: MariaDB is configured to use just 64M memory (innodb_buffer_pool_size is set to it) unless on the initial startup you provide environment variable MARIADB_INNODB_BUFFER_POOL_SIZE to override it.

## Usage
Pull the image from Docker Hub
`docker pull 0xmjk/alpine-mariadb-server`

At first run, provide a *hashed* password in MARIADB_ROOT_PASSWORD environment variable:
`docker run -d -p 3306:3306 -v /data/mysql:/var/lib/mysql -e MARIADB_ROOT_PASSWORD="*EEFFAA..." 0xmjk/alpine-mariadb-server`

This will initialise MariaDB files in /data/mysql on your Docker host.

Note, the root user is granted to do `ALL` from anyhost with the set password. You may need to alter your grant table if you want tighter ACL.  

After the first run you can start the server with:

`docker run -d -p 3306:3306 -v /data/mysql:/var/lib/mysql 0xmjk/alpine-mariadb-server`




