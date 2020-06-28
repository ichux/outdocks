FORMAT="\nID\t{{.ID}}\nIMAGE\t{{.Image}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.RunningFor}}\nSTATUS\t\
{{.Status}}\nPORTS\t{{.Ports}}\nNAMES\t{{.Names}}\n"

SCHEMA_TABLE = SELECT schemaname,tablename FROM pg_catalog.pg_tables WHERE schemaname \
NOT IN ('information_schema','pg_catalog') ORDER BY schemaname,tablename

RDB = docker-compose --project-name pgsql run --rm dbpsql

# psql -U postgres -c "DROP DATABASE avdb;"

# docker rm -f pg12 # force remove a container
# psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" && createdb -O docker docker
# remove all images: docker rmi $(docker images -a -q)
# remove exited docker: docker rm $(docker ps -a -f status=exited -q)
# stop all containers: docker stop $(docker ps -a -q)
# docker images -a | grep "none" | awk '{print $3}' | xargs docker rmi

help:
	@echo "\`make <target>\` where <target> is one of"
	@echo "  dip		check the container details"
	@echo "  bash		to make bash for the docker environment"
	@echo "  logs		to make logs for the docker environment show up"
	@echo "  up		powers up the container"
	@echo "  net		checks the network details"
	@echo "  down		powers down the container and properly cleans up"
	@echo "  start	starts the container"
	@echo "  rs	    restarts the container"
	@echo "  stop		stops the container"
	@echo "  stat		show some statistics about the docker system"
	@echo "  tail		to tail the psqlv12 container"
	@echo "  prune		properly cleans up the containers."
	@echo "  opt		see the DB options used"
	@echo "  config	displays the docker configuration"
	@echo "  ud		produce user details for pgbouncer"
	@echo "  cr8		create and run SQL statements"
	@echo "  pgstat	creates the pg_stat_statements extension if need be"
	@echo "  csv		copy out the loaded tables in .csv format"

dip:
	docker inspect psqlv12

bash:
	docker exec -it psqlv12 bash

logs:
	docker-compose --project-name pgsql logs --timestamps --follow

up:
	@docker network ls | grep idev > /dev/null || docker network create --driver bridge idev
	@docker-compose --project-name pgsql up --build -d
	@sleep 5s && make pgstat

net:
	@docker network inspect idev

down:
	@docker-compose --project-name pgsql down

stop:
	@docker-compose --project-name pgsql stop
	@make stat

start:
	@docker-compose --project-name pgsql start

rs:
	@docker-compose --project-name pgsql restart

stat:
	@# docker ps -a --format $(FORMAT)
	@docker ps -a && echo
	@docker images; echo; echo "docker rmi "

tail:
	@docker logs psqlv12 --timestamps --follow

tardata:
	@# back up the /var/lib/postgresql/data/
	@# and extract
	@#docker run --rm --volumes-from psqlv12 -it busybox tar -zcf /queries/psqldata.tar.gz -C /var/lib/postgresql data/
	@#docker run --rm --volumes-from psqlv12 -it busybox tar -xf /queries/psqldata.tar.gz -C /var/lib/postgresql

opt:
	@docker run --rm --volumes-from psqlv12 -it busybox cat /etc/postgresql/postgresql.conf && echo "\n"
	@docker run --rm --volumes-from psqlv12 -it busybox cat /var/lib/postgresql/data/pg_hba.conf && echo "\n"
	@docker exec -it psqlv12 ls / && echo "\n"
	@# $(RDB) cat /usr/share/postgresql/postgresql.conf.sample > postgresql.conf.sample

config:
	docker-compose --project-name pgsql config

ud:
	# get the user details that you could use for pgbouncer `userlist.txt`
	@$(RDB) psql -Atq "postgresql://postgres:SQL085bc2@dbpsql:5432" -c "SELECT concat('\"', usename, '\" \"', passwd, '\"') FROM pg_shadow"

cr8:
	@echo "run SQL queries here if you know what you are doing. See examples below:"
	# https://www.postgresql.org/docs/12/plpgsql.html
	# http://www.postgresql.cn/docs/12/plpgsql-development-tips.html

	@$(RDB) psql "postgresql://postgres:SQL085bc2@dbpsql:5432" -c "CREATE USER evolves WITH PASSWORD 'b15c6d50b94b2';"
	@$(RDB) psql "postgresql://postgres:SQL085bc2@dbpsql:5432" -c "CREATE DATABASE evolves OWNER evolves;"

pgstat:
	$(RDB) psql "postgresql://postgres:SQL085bc2@dbpsql:5432" -c 'CREATE EXTENSION IF NOT EXISTS pg_stat_statements;'

bup:
	@# docker exec -it psqlv12 pg_dump -U postgres -F t alldb
	docker exec -it psqlv12 pg_dump -U postgres -F t alldb --file=/queries/alldb.dump
	@# docker exec -it psqlv12 pg_dump -U postgres -F t alldb --schema-only --file=/queries/alldb-schema-only.sql
	@# docker exec -it psqlv12 pg_dump -U postgres -F t alldb --data-only --file=/queries/alldb-data-only.sql
	@# @docker exec -it -e PGPASSWORD=SQL085bc2 psqlv12 pg_dump -h localhost -U postgres alldb > alldb.sql

ddb:
	docker exec -it psqlv12 pg_dump alldb -U postgres --role=alldb --file=/queries/alldb.sql
	@# psql -f /queries/alldb_loaded-tables.sql -U postgres -d alldb
	@# COPY table_name (tags,image) FROM '/queries/alldb_loaded-tables.csv';

csv:
	@# $(RDB) psql -Atq "postgresql://postgres:SQL085bc2@dbpsql:5432" -c "COPY ($(SCHEMA_TABLE)) TO '/queries/postgres_loaded-tables.csv' DELIMITER ',' CSV HEADER;"
	@$(RDB) psql "postgresql://postgres:SQL085bc2@dbpsql:5432/alldb" -c "COPY ($(SCHEMA_TABLE)) TO '/queries/alldb_loaded-tables.csv' DELIMITER ',' CSV HEADER;"

prune:
	@docker container prune -f
	# @docker volume prune -f && docker network prune -f
	@make stat

.PHONY: prune csv dumps pgstat cr8 ud config opt tail stat stop down net up logs bash dip psqldata
