up:
	@docker network ls | grep idev > /dev/null || docker network create --driver bridge idev
	@docker-compose --project-name redis up --build -d

down:
	@docker-compose --project-name redis down

bash:
	docker exec -it redisv6.0.3 bash

stop:
	@docker-compose --project-name redis stop

start:
	@docker-compose --project-name redis start
