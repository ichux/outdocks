up:
	@docker network ls | grep idev > /dev/null || docker network create --driver bridge idev
	@docker-compose --project-name mysql up --build -d

down:
	@docker-compose --project-name mysql down

bash:
	docker exec -it mysqlv8.0.20 bash

dumps:
	docker exec mysqlv8.0.20 bash -c 'exec mysqldump --all-databases -uroot -pe81bc8e51' > all-databases.sql

html:
	@docker exec -i mysqlv8.0.20 bash -c 'exec mysql -uroot -p$(p) --html --database=idb --execute="SELECT * FROM migration_tbl"'

test:
	@#make test p=e81bc8e51
	@docker exec -i mysqlv8.0.20 bash -c 'exec mysql -uroot -p$(p) --execute="SELECT VERSION() as VERSION\GSELECT NOW() AS NOW\G"'
	@echo
	@docker exec -i mysqlv8.0.20 bash -c 'exec mysql -uroot -p$(p) --execute="SELECT VERSION() as VERSION;SELECT NOW() AS NOW;"'

cdb:
	@#URL: https://dev.mysql.com/doc/refman/8.0/en/mysql-command-options.html
	@# make cdb p=e81bc8e51 d=edb
	@#echo "CREATE DATABASE IF NOT EXISTS $(d)" | docker exec -i mysqlv8.0.20 bash -c 'exec mysql -uroot -p$(p)'
	@docker exec -i mysqlv8.0.20 bash -c 'exec mysql -uroot -p$(p) --execute="CREATE DATABASE IF NOT EXISTS $(d)"'

ddb:
	@# make ddb p=e81bc8e51 d=edb
	@#echo "DROP DATABASE IF EXISTS $(d);" | docker exec -i mysqlv8.0.20 bash -c 'exec mysql -uroot -p$(p)'
	@docker exec -i mysqlv8.0.20 bash -c 'exec mysql -uroot -p$(p) --execute="DROP DATABASE IF EXISTS $(d)"'

loads:
	# echo "CREATE DATABASE IF NOT EXISTS `idb`" | mysql -u username -p
	docker exec -i mysqlv8.0.20 bash -c 'exec mysql -uroot -pe81bc8e51' < all-databases.sql

stop:
	@docker-compose --project-name mysql stop

start:
	@docker-compose --project-name mysql start

rs:
	@docker-compose --project-name mysql restart
