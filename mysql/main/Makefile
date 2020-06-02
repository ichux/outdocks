up:
	@docker network ls | grep idev > /dev/null || docker network create --driver bridge idev
	@docker-compose --project-name mysql up --build -d

down:
	@docker-compose --project-name mysql down

bash:
	docker exec -it mysqlv8.0.20 bash

dumps:
	docker exec mysqlv8.0.20 bash -c 'exec mysqldump --all-databases -uroot -pe81bc8e51' > all-databases.sql

loads:
	docker exec -i mysqlv8.0.20 bash -c 'exec mysql -uroot -pe81bc8e51' < all-databases.sql

stop:
	@docker-compose --project-name mysql stop

start:
	@docker-compose --project-name mysql start
