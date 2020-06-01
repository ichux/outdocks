.PHONY: sd bu stat ed eu ui co


help:
	@echo "\`make <target>\` where <target> is one of"
	@echo "  co		clean off images. Be careful with this"
	@echo "  sd		shut down all the container instances"
	@echo "  bu		boot up all the container instances"
	@echo "  ed		shows how to take each container instances down"
	@echo "  eu		shows how to take each container instances up"
	@echo "  ui		update images used for containers"

co:
	docker image prune -a

sd:
	@$(MAKE) -C redis down
	@$(MAKE) -C phpadminer down
	@$(MAKE) -C pgadmin down
	@$(MAKE) -C mariadb/main down
	@$(MAKE) -C mysql/main down
	@$(MAKE) -C pgbouncer down
	@$(MAKE) -C postgresql/main down

	@printf "\033c"
	@make stat

bu:
	@$(MAKE) -C postgresql/main up
	@$(MAKE) -C pgbouncer up
	@$(MAKE) -C mysql/main up
	@$(MAKE) -C mariadb/main up
	@$(MAKE) -C pgadmin up
	@$(MAKE) -C phpadminer up
	@$(MAKE) -C redis up

	@printf "\033c"
	@make stat

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

stat:
	@docker network inspect idev
	@docker ps -a && docker images && echo 'docker rmi '

ui:
	docker pull redis:6.0.3
	docker pull mariadb:10.5.3
	docker pull adminer:4.7
	docker pull mysql:8.0.20
	docker pull alpine:3.11
	docker pull postgres:12.2

	docker pull dpage/pgadmin4:latest
	docker pull busybox:latest
