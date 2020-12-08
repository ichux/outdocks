up:
	@docker-compose up --remove-orphan --build -d

down:
	@docker-compose down

bash:
	@docker exec -it mariadb sh

dumps:
	@#make dumps p=password
	@docker exec mariadb sh -c 'exec mysqldump --all-databases -uroot -p$(p)' > all-databases.sql

loads:
	@#make dumps p=password
	@docker exec -i mariadb sh -c 'exec mysql -uroot -p$(p)' < all-databases.sql

start:
	@docker-compose start

rs:
	@docker-compose restart

stop:
	@docker-compose stop
