.PHONY: sd bu stat ed eu ui co op rt eo er


help:
	@echo "\`make <target>\` where <target> is one of"
	@echo "  co		clean off images. Be careful with this"
	@echo "  op		stops containers"
	@echo "  rs		restarts the containers"
	@echo "  rt		starts already stopped containers"
	@echo "  sd		shut down all the container instances"
	@echo "  bu		boot up all the container instances"
	@echo "  ed		shows how to take each container instances down"
	@echo "  eu		shows how to take each container instances up"
	@echo "  ui		update images used for containers"

co:
	docker image prune -a

op:
	@$(MAKE) -C redis stop
	@$(MAKE) -C phpadminer stop
	@$(MAKE) -C pgadmin stop
	@$(MAKE) -C mariadb/main stop
	@$(MAKE) -C mysql/main stop
	@$(MAKE) -C pgbouncer stop
	@$(MAKE) -C postgresql/main stop

rs:
	@$(MAKE) -C postgresql/main rs
	@$(MAKE) -C pgbouncer rs
	@$(MAKE) -C mysql/main rs
	@$(MAKE) -C mariadb/main rs
	@$(MAKE) -C pgadmin rs
	@$(MAKE) -C phpadminer rs
	@$(MAKE) -C redis rs

rt:
	@$(MAKE) -C postgresql/main start
	@$(MAKE) -C pgbouncer start
	@$(MAKE) -C mysql/main start
	@$(MAKE) -C mariadb/main start
	@$(MAKE) -C pgadmin start
	@$(MAKE) -C phpadminer start
	@$(MAKE) -C redis start

sd:
	@$(MAKE) -C redis down
	@$(MAKE) -C phpadminer down
	@$(MAKE) -C pgadmin down
	@$(MAKE) -C mariadb/main down
	@$(MAKE) -C mysql/main down
	@$(MAKE) -C pgbouncer down

	@printf "\033c"
	@$(MAKE) -C postgresql/main down
	@$(MAKE) -C postgresql/main net
	@$(MAKE) -C postgresql/main stat

bu:
	@$(MAKE) -C postgresql/main up
	@$(MAKE) -C pgbouncer up
	@$(MAKE) -C mysql/main up
	@$(MAKE) -C mariadb/main up
	@$(MAKE) -C pgadmin up
	@$(MAKE) -C phpadminer up
	@$(MAKE) -C redis up

	@printf "\033c"
	@$(MAKE) -C postgresql/main net
	@$(MAKE) -C postgresql/main stat

eo:
	@echo make -C redis stop
	@echo make -C phpadminer stop
	@echo make -C pgadmin stop
	@echo make -C mariadb/main stop
	@echo make -C mysql/main stop
	@echo make -C pgbouncer stop
	@echo make -C postgresql/main stop

er:
	@echo make -C postgresql/main start
	@echo make -C pgbouncer start
	@echo make -C mysql/main start
	@echo make -C mariadb/main start
	@echo make -C pgadmin start
	@echo make -C phpadminer start
	@echo make -C redis start

es:
	@echo make -C postgresql/main rs
	@echo make -C pgbouncer rs
	@echo make -C mysql/main rs
	@echo make -C mariadb/main rs
	@echo make -C pgadmin rs
	@echo make -C phpadminer rs
	@echo make -C redis rs

ed:
	@echo make -C redis down
	@echo make -C phpadminer down
	@echo make -C pgadmin down
	@echo make -C mariadb/main down
	@echo make -C mysql/main down
	@echo make -C pgbouncer down
	@echo make -C postgresql/main down

eu:
	@echo make -C postgresql/main up
	@echo make -C pgbouncer up
	@echo make -C mysql/main up
	@echo make -C mariadb/main up
	@echo make -C pgadmin up
	@echo make -C phpadminer up
	@echo make -C redis up


ui:
	docker pull redis:6.0.3
	docker pull mariadb:10.5.3
	docker pull adminer:4.7
	docker pull mysql:8.0.20
	docker pull alpine:3.11
	docker pull postgres:12.2

	docker pull dpage/pgadmin4:latest
	docker pull busybox:latest
