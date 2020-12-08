# Adminer 4.7
Version of Adminer in use.

## CREATE NETWORK
Create the initial network that the docker containers will work with

```
docker network ls | grep outdocks > /dev/null || docker network create \
  --ipam-driver=default --gateway=172.30.0.1 --attachable=true \
  --driver=bridge --subnet=172.30.0.0/16 outdocks
```

To check for the status of the docker network at any point in time:
> docker network inspect outdocks

## CONTAINER IP
ip: 172.30.100.100

## START UP PROCESS
1. create the network, as stated above
2. cp .env-example .env
3. alter the variable in .env that was created above to taste

## DOCKER INITIALIZATION GUIDELINE
* Run `docker-compose --project-name od2 up --remove-orphan --build -d` to build and run the containers.
* Run `docker-compose --project-name od2 logs --timestamps --follow`

## RUN TESTS
1. Check to see that it's running at a specified port
```echo quit | telnet URL PORT```
2. See the details of the network
```docker network inspect outdocks```

## MORE INFORMATION
Check the Makefile and run as many commands in it as you can run. Some may need adjustments.
