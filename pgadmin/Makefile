# to login in with this adminer to a DB like sqlite, use the password: 'admin'

up:
	@docker network ls | grep idev > /dev/null || docker network create --driver bridge idev
	@docker-compose --project-name pgadmin up --build -d

down:
	@docker-compose --project-name pgadmin down

bash:
	docker exec -it pgadmin4 bash

logs:
	docker-compose --project-name pgadmin logs --timestamps --follow

start:
	@docker-compose --project-name pgadmin start

rs:
	@docker-compose --project-name pgadmin restart

stop:
	@docker-compose --project-name pgadmin stop
