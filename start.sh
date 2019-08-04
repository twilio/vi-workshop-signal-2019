#!/bin/bash

echo "Usage: $(basename $0) <docker_file> <base_dir_for_data>"

FORCE_RECREATE=1
BUILD=0

DOCKER_FILE="${PWD}/docker-compose-hive.yml"
DOCKER_NETWORK=spark-net
DOCKER_CMD="docker-compose -f ${DOCKER_FILE} up -d --remove-orphans"
CONTAINER_LIST="\
    namenode datanode \
    spark-master \
    spark-worker \
    wait/10 \
    zeppelin"

function init() {
    chmod +x -R "${PWD}/scripts/"
    rm -r hadoop/datanode/
    mkdir hadoop/datanode

    rm -r hadoop/namenode/
    mkdir hadoop/namenode
}

function checkDockerInstall() {
    echo "check if docker is installed"
    command -v docker
    if [ $? -eq 0 ]; then
        echo OK
    else
        echo FAIL
        exit 0
    fi
}

function startDockerNetwork() {
    echo "clearing old docker network ${DOCKER_NETWORK}"
    docker network rm ${DOCKER_NETWORK}
    echo "starting docker network ${DOCKER_NETWORK} in bridge mode"
    docker network create -d bridge ${DOCKER_NETWORK}
}

function startDockerContainers() {
    for c in $CONTAINER_LIST; do
        echo "CONTAINER: ${c}"
        if [[ "$c" =~ wait ]]; then
            wait_sec=$(basename $c)
            echo "... waiting for ${wait_sec} seconds ..."
            sleep ${wait_sec}
        else
          echo "Issuing Docker Command: ${DOCKER_CMD} $c"
          ${DOCKER_CMD} $c
        fi
    done
}

function printServicePorts() {
    my_ip=`hostname`
    echo "NameNode ICP: PORT 8020"
    echo "Namenode: http://${my_ip}:50070"
    echo "Datanode: http://${my_ip}:50075"
    echo "Spark-master: http://${my_ip}:8090"
    echo "Spark-worker: http://${my_ip}:8091"
    echo "Zeppelin: http://${my_ip}:8080"
}

function importData() {
    echo "importing all data into hdfs. /voiceinsights/signal2019/data/"
    docker exec -it namenode scripts/bootstrap-hdfs.sh
    echo "all data is now available in hdfs"
}

function start() {
    init
    checkDockerInstall
    echo "DockerFile: ${DOCKER_FILE}"
    docker rm -f `docker ps -aq` # delete old containers
    startDockerNetwork
    startDockerContainers
    importData
    printServicePorts
}

start
