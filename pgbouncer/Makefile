logs:
	@docker-compose --project-name od3 logs --timestamps --follow

down:
	@docker-compose --project-name od3 down

start:
	@docker-compose --project-name od3 start pool

rs:
	@docker-compose --project-name od3 restart pool

stop:
	@docker-compose --project-name od3 stop

up:
	@# docker images | grep bounce01 | awk '{print $3}'
	@docker-compose --project-name od3 up --no-start --build
	@docker-compose --project-name od3 up -d pool

	@# clean up unwanted
	@docker rm bounce01 2> /dev/null || true
	@docker network rm od3_default

shell:
	@docker exec -it pool sh
