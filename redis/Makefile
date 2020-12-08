up:
	@docker network ls | grep idev > /dev/null || docker network create --driver bridge idev
	@docker-compose --project-name outdocks up --build -d

down:
	@docker-compose --project-name outdocks down

bash:
	docker exec -it redisv6 bash

stop:
	@docker-compose --project-name outdocks stop

start:
	@docker-compose --project-name outdocks start

rs:
	@docker-compose --project-name outdocks restart
