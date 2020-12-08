SCHEMA_TABLE = SELECT schemaname,tablename FROM pg_catalog.pg_tables WHERE schemaname \
NOT IN ('information_schema','pg_catalog') ORDER BY schemaname,tablename

PITCH = docker-compose --project-name od1
CLINE = docker exec -i psql13

# psql -U postgres -c "DROP DATABASE avdb;"

# docker rm -f pg13 # force remove a container
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
	@echo "  tail		to tail the psql13 container"
	@echo "  prune		properly cleans up the containers."
	@echo "  opt		see the DB options used"
	@echo "  config	displays the docker configuration"
	@echo "  ud		produce user details for pgbouncer"
	@echo "  cr8		create and run SQL statements"
	@echo "  pgstat	creates the pg_stat_statements extension if need be"
	@echo "  csv		copy out the loaded tables in .csv format"

dip:
	@docker inspect psql13

bash:
	@docker exec -it psql13 bash

logs:
	@docker-compose --project-name od1 logs --timestamps --follow

net:
	@docker network inspect outdocks

down:
	@$(PITCH) down

stop:
	@$(PITCH) stop

start:
	@$(PITCH) start

rs:
	@$(PITCH) restart

tail:
	@docker logs psql13 --timestamps --follow

tardata:
	@# back up the /var/lib/postgresql/data/
	@# and extract
	@#docker run --rm --volumes-from psql13 -it busybox tar -zcf /queries/psqldata.tar.gz -C /var/lib/postgresql data/
	@#docker run --rm --volumes-from psql13 -it busybox tar -xf /queries/psqldata.tar.gz -C /var/lib/postgresql

opt:
	@docker run --rm --volumes-from psql13 -it busybox cat /etc/postgresql/postgresql.conf && echo "\n"
	@docker run --rm --volumes-from psql13 -it busybox cat /var/lib/postgresql/data/pg_hba.conf && echo "\n"
	@docker exec -it psql13 ls / && echo "\n"
	@# $(RDB) cat /usr/share/postgresql/postgresql.conf.sample > postgresql.conf.sample

config:
	@$(PITCH) config

ud:
	@# get the user details that you could use for pgbouncer `userlist.txt`
	@$(CLINE) psql -Atq "postgresql://postgres:SQL085bc2@psql13:5432" -c "SELECT concat('\"', usename, '\" \"', passwd, '\"') FROM pg_shadow"

cr8:
	@echo "run SQL queries here if you know what you are doing. See examples below:"
	# https://www.postgresql.org/docs/13/ploutdocks.html
	# http://www.postgresql.cn/docs/13/ploutdocks-development-tips.html

	@$(CLINE) psql "postgresql://postgres:SQL085bc2@psql13:5432" -c "CREATE USER evolves WITH PASSWORD 'b15c6d50b94b2';"
	@$(CLINE) psql "postgresql://postgres:SQL085bc2@psql13:5432" -c "CREATE DATABASE evolves OWNER evolves;"

pgstat:
	@$(CLINE) psql "postgresql://postgres:SQL085bc2@psql13:5432" -c 'CREATE EXTENSION IF NOT EXISTS pg_stat_statements;'

bup:
	@# docker exec -it psql13 pg_dump -U postgres -F t alldb
	docker exec -it psql13 pg_dump -U postgres -F t alldb --file=/queries/alldb.dump
	@# docker exec -it psql13 pg_dump -U postgres -F t alldb --schema-only --file=/queries/alldb-schema-only.sql
	@# docker exec -it psql13 pg_dump -U postgres -F t alldb --data-only --file=/queries/alldb-data-only.sql
	@# @docker exec -it -e PGPASSWORD=SQL085bc2 psql13 pg_dump -h localhost -U postgres alldb > alldb.sql

ddb:
	docker exec -it psql13 pg_dump alldb -U postgres --role=alldb --file=/queries/alldb.sql
	@# psql -f /queries/alldb_loaded-tables.sql -U postgres -d alldb
	@# COPY table_name (tags,image) FROM '/queries/alldb_loaded-tables.csv';

csv:
	@$(CLINE) psql "postgresql://postgres:SQL085bc2@psql13:5432/alldb" -c "COPY ($(SCHEMA_TABLE)) TO '/queries/alldb_loaded-tables.csv' DELIMITER ',' CSV HEADER;"

prune:
	@docker container prune -f
	# @docker volume prune -f && docker network prune -f

.PHONY: prune csv dumps pgstat cr8 ud config opt tail stat stop down net up logs bash dip psqldata
