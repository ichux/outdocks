logs:
	@docker-compose --project-name bounce logs --timestamps --follow

down:
	@docker-compose --project-name bounce down

stop:
	@docker-compose --project-name bounce stop

up:
	# docker images | grep pgbouncer_dbpool | awk '{print $3}'
	@docker network ls | grep idev > /dev/null || make idevnet
	@docker images | grep devbouncer > /dev/null || make obase
	@docker-compose --project-name bounce up --build -d

idevnet:
	@docker network create --driver bridge idev

obase:
	@cd base && docker build -t devbouncer .

shell:
	docker exec -it pgbouncer sh

net:
	@docker network inspect idev
