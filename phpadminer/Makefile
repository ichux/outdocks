# to login in with this adminer to a DB like sqlite, use the password: 'admin'

up:
	@docker network ls | grep idev > /dev/null || docker network create --driver bridge idev
	@docker-compose --project-name phpadminer up --build -d

down:
	@docker-compose --project-name phpadminer down

logs:
	docker-compose --project-name phpadminer logs --timestamps --follow

start:
	@docker-compose --project-name phpadminer start

rs:
	@docker-compose --project-name phpadminer restart

stop:
	@docker-compose --project-name phpadminer stop
