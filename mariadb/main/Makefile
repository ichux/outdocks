up:
	@docker network ls | grep idev > /dev/null || docker network create --driver bridge idev
	@docker-compose --project-name mariadb up --build -d

down:
	@docker-compose --project-name mariadb down

bash:
	docker exec -it mariadbv10.5.3 bash

dumps:
	docker exec mariadbv10.5.3 bash -c 'exec mysqldump --all-databases -uroot -pe81bc8e51' > all-databases.sql

loads:
	docker exec -i mariadbv10.5.3 bash -c 'exec mysql -uroot -pe81bc8e51' < all-databases.sql

start:
	@docker-compose --project-name mariadb start

rs:
	@docker-compose --project-name mariadb restart

stop:
	@docker-compose --project-name mariadb stop
