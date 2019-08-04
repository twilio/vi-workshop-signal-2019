# Zeppelin for Spark + Hadoop (SIGNAL 2019)

Signal Docker Container (spark,hdfs,etc)

### Docker
1. Install Docker Desktop (https://www.docker.com/products/docker-desktop)
Additional Docker Resources:
* https://docs.docker.com/get-started/
* https://hub.docker.com/

#### Docker Runtime Recommendations
1. 2 or more cpu cores.
2. 8gb/ram or higher.

### Getting Started
1. Build the Docker Container `./build.sh`
2. Start the Environment `./start.sh`
3. If all goes well then http://localhost:8080/ should have Zeppelin up and running. (park Primer: http://localhost:8080/#/notebook/2EHFGMBH5)

## Build 
The Dockerfile is used to build Zeppelin which has dependency on the rest of other docker containers Hadoop and Spark

### Build the Zeppelin Docker Container
Note: Building the initial docker container can take anywhere from 5-20 minutes. Please be patient!
~~~bash
./build.sh
~~~

### Start up the Environment
To start the entire image with spark + hadoop + zeppelin:
~~~bash
./start.sh
~~~

### Stopping the Environment
~~~bash
./stop.sh
~~~

### Docker Info

List all running docker processes
~~~
docker ps
~~~

### Log into a Docker Container VM
You just need to launch a bash session.

`docker exec -it CONTAINER_NAME command`
~~~bash
docker exec -it zeppelin /bin/bash
~~~
