# MariaDB Server v10.5
Version of MariDB in use.

## CREATE VOLUME
Make a directory that will store MySQL data

## CREATE NETWORK
Create the initial network that the docker containers will work with

```
docker network ls | grep outdocks > /dev/null || docker network create \
  --ipam-driver=default --gateway=172.30.0.1 --attachable=true \
  --driver=bridge --subnet=172.30.0.0/16 outdocks
```

To check for the status of the docker network at any point in time:
> docker network inspect outdocks

## VARIABLES
The file `.env-example` contains all the dynamic variables.
Create yours as `cp .env-example .env` and alter your variables to taste.

## MARIADB DIRECTORIES
Create 2 directories `MARIADB_DATA` and `MARIADB_CONFD` and refer to them within your `.env`. 
MariaDB will make use of that location.

## MARIADB CONFIG
*Note*: You can totally skip this part or work with it later on, as you wish!

1. nano MARIADB_CONFD/mariadb.cnf.
2. Add the following below to the file created above, or whatever variable you intend to change
```
[mysqld]
max_connections=100
wait_timeout=180
net_read_timeout=90
net_write_timeout=90
interactive_timeout=300
connect_timeout=90
max_allowed_packet=512M

# Disable two DNS lookups per authentication attempt
# MySQL server will only use IP addresses, instead of hostnames
skip-name-resolve
```
3. If the container is already running `docker-compose up --build -d` and use the command below to verify that it worked:

> echo 'show global variables like "max_connections"\G' | docker exec -i mariadb sh -c 'exec mysql -uroot -pda836eeb2'

## CONTAINER IP
ip: 172.30.0.5

## START UP PROCESS
1. create the network, as stated above
2. create the volume, as stated above
3. cp .env-example .env
4. alter the variable in .env that was created above to taste

## DOCKER INITIALIZATION GUIDELINE
* Run `docker-compose up --remove-orphan --build -d` to build and run the containers.
* Run `docker-compose logs --timestamps --follow`

## RUN TESTS
1. Check to see that it's running at a specified port
```echo quit | telnet URL PORT```
2. See the details of the network
```docker network inspect outdocks```

## MORE INFORMATION
Check the Makefile and run as many commands in it as you can run. Some may need adjustments.

## RANDOM COMMANDS: ALTER YOUR PASSWORD TO TASTE
*CREATE A DB - school*
```
docker exec -i mariadb sh -c \
   'exec mysql -uroot -pda836eeb2 \
   -e "CREATE DATABASE school CHARACTER SET \
    utf8mb4 COLLATE utf8mb4_unicode_ci"'
```

*DROP THE DB - school*
```
echo "DROP DATABASE school" | docker exec -i mariadb sh \
   -c 'exec mysql -uroot -pda836eeb2'
```
