#!/bin/bash -x

docker-compose -f docker-compose-hive.yml down $*

# All container processes should be offline now
echo "checking things have shutdown"
docker ps

function clear() {
    rm -r hadoop/datanode/
    mkdir hadoop/datanode
    rm -r hadoop/namenode/
    mkdir hadoop/namenode

    # kill off the zeppelin logs
    rm logs/*.log
}

clear
