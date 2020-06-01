help:
	@echo "\`make <target>\` where <target> is one of"
	@echo "  sd		shutdown all the container instances"
	@echo "  bu		boot up all the container instances"
	@echo "  ed		shows how to take each container instances down"
	@echo "  ed		shows how to take each container instances up"

sd:
	@$(MAKE) -C mariadb/main down
	@$(MAKE) -C mysql/main down
	@$(MAKE) -C redis down
	@$(MAKE) -C pgbouncer down
	@$(MAKE) -C postgresql/main down

	@printf "\033c"
	@make stat

bu:
	@$(MAKE) -C postgresql/main up
	@$(MAKE) -C pgbouncer up
	@$(MAKE) -C redis up
	@$(MAKE) -C mysql/main up
	@$(MAKE) -C mariadb/main up

	@printf "\033c"
	@make stat

ed:
	@echo make -C mariadb/main down
	@echo make -C mysql/main down
	@echo make -C redis down
	@echo make -C pgbouncer down
	@echo make -C postgresql/main down

eu:
	@echo make -C postgresql/main up
	@echo make -C pgbouncer up
	@echo make -C redis up
	@echo make -C mysql/main up
	@echo make -C mariadb/main up

stat:
	@docker network inspect idev
	@docker ps -a && docker images && echo 'docker rmi '

.PHONY: sd bu stat ed eu
