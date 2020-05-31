#!/bin/bash

# starts postgresql
cd postgresql/main && make up && cd ../..

# starts pgbouncer
cd pgbouncer && make up && cd ..

# starts redis
cd redis && make up && cd ..

# starts MariaDB
cd mysql/main/ && make up && cd ../..

# starts MariaDB
cd mariadb/main/ && make up && cd ../..

docker network inspect idev
docker ps -a && docker images && echo 'docker rmi '
