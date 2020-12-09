logs:
	@docker-compose --project-name bounce logs --timestamps --follow

down:
	@docker-compose --project-name bounce down

start:
	@docker-compose --project-name bounce start dbpool

rs:
	@docker-compose --project-name bounce restart dbpool

stop:
	@docker-compose --project-name bounce stop

up:
	# docker images | grep pgbouncer_dbpool | awk '{print $3}'
	@docker network ls | grep idev > /dev/null || make idevnet
	@docker-compose --project-name bounce up --no-start --build
	@docker-compose --project-name bounce up -d dbpool

	@# bash -c '[ "$(docker ps -a | grep bounce_devbouncer_1)" ] && docker rm bounce_devbouncer_1 2> /dev/null || true'
	@docker rm bounce_devbouncer_1 2> /dev/null || true

idevnet:
	@docker network create --driver bridge idev

shell:
	docker exec -it pgbouncer sh

net:
	@docker network inspect idev
