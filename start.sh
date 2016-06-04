#!/bin/bash

set -x
set -e

if [ ! -x /var/lib/mysql/mysql ]; then
    : "${MARIADB_ROOT_PASSWORD:?Set MARIADB_ROOT_PASSWORD environment variable to a password hash at first run}"
    tee /etc/mysql/my.cnf <<EOF
[client]
port=3306
socket=/run/mysqld/mysqld.sock

[mysqld]
port=3306
socket=/run/mysqld/mysqld.sock
user=mysql
query_cache_size=0
binlog_format=ROW
default_storage_engine=innodb
innodb_autoinc_lock_mode=2
# innodb_doublewrite=1 - this is the default and it should stay this way

# 2. Optional mysqld settings: your regular InnoDB tuning and such
innodb_buffer_pool_size=${MARIADB_INNODB_BUFFER_POOL_SIZE:-64M}
innodb_log_file_size=100M
innodb_file_per_table
innodb_flush_log_at_trx_commit=2
EOF
    echo Initializing /var/lib/mysql
    mysql_install_db
    echo Starting mysqld
    mysqld &
    sleep 3
    echo Set up grants
    mysql <<EOF
        UPDATE mysql.user SET Password='${MARIADB_ROOT_PASSWORD}' WHERE User='root';
        GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY PASSWORD '${MARIADB_ROOT_PASSWORD}';
        DELETE FROM mysql.user WHERE User='';
        DROP DATABASE test;
        DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
        FLUSH PRIVILEGES;
EOF
    kill %1
    sleep 3
fi

exec mysqld_safe  

