#!/bin/bash

# stops MariaDB
cd mariadb/main/ && make down && cd ../..

# stops MariaDB
cd mysql/main/ && make down && cd ../..

# stops redis
cd redis && make down && cd ..

# stops pgbouncer
cd pgbouncer && make down && cd ..

# stops postgresql
cd postgresql/main && make down && cd ../..

docker network inspect idev
docker ps -a && docker images && echo 'docker rmi '
