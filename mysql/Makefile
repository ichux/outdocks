up:
	@docker-compose up --remove-orphan --build -d

down:
	@docker-compose down

bash:
	docker exec -it mysqlv8 sh

dumps:
	@#make dumps p=password
	docker exec mysqlv8 sh -c 'exec mysqldump --all-databases -uroot -p$(p)' > all-databases.sql

html:
	@#make html p=password
	@docker exec -i mysqlv8 sh -c 'exec mysql -uroot -p$(p) --html --database=idb --execute="SELECT * FROM migration_tbl"'

now:
	@#make now p=e81bc8e51
	@docker exec -i mysqlv8 sh -c 'exec mysql -uroot -p$(p) --execute="SELECT VERSION() as VERSION\GSELECT NOW() AS NOW\G"'
	@echo
	@docker exec -i mysqlv8 sh -c 'exec mysql -uroot -p$(p) --execute="SELECT VERSION() as VERSION;SELECT NOW() AS NOW;"'

cdb:
	@#URL: https://dev.mysql.com/doc/refman/8.0/en/mysql-command-options.html
	@# make cdb p=e81bc8e51 d=edb
	@#echo "CREATE DATABASE IF NOT EXISTS $(d)" | docker exec -i mysqlv8 sh -c 'exec mysql -uroot -p$(p)'
	@docker exec -i mysqlv8 sh -c 'exec mysql -uroot -p$(p) --execute="CREATE DATABASE IF NOT EXISTS $(d)"'

ddb:
	@# make ddb p=e81bc8e51 d=edb
	@#echo "DROP DATABASE IF EXISTS $(d);" | docker exec -i mysqlv8 sh -c 'exec mysql -uroot -p$(p)'
	@docker exec -i mysqlv8 sh -c 'exec mysql -uroot -p$(p) --execute="DROP DATABASE IF EXISTS $(d)"'

loads:
	@# echo "CREATE DATABASE IF NOT EXISTS `idb`" | mysql -u username -p
	@#make loads p=password
	docker exec -i mysqlv8 sh -c 'exec mysql -uroot -p$(p)' < all-databases.sql

stop:
	@docker-compose stop

start:
	@docker-compose start

rs:
	@docker-compose restart
