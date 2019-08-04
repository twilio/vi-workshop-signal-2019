#!/bin/sh

#function checkInstall() {
#  command -v hdfs
#  if [ $? -eq 0 ]; then
#    echo "hdfs is symlinked and available. Woot"
#  else
#    echo "hdfs command is missing. Ouch. Try rebuilding the Docker containers. ./stop.sh && ./build.sh && start.sh"
#    exit 0
#  fi
#}

#function createSignalFilePaths() {
#  echo "creating signal2019 data paths"
#  hdfs dfs -mkdir /voiceinsights
#  hdfs dfs -mkdir /voiceinsights/signal2019
#  hdfs dfs -mkdir /voiceinsights/signal2019/data
#  hdfs dfs -ls /
#}

#function importAllFiles() {
#  hdfs dfs -put /signaldata/* /voiceinsights/signal2019/data
#  hdfs dfs -ls /voiceinsights/signal2019/data/
#}

echo "checking hdfs install"
command -v hdfs
if [ $? -eq 0 ]; then
  echo "hdfs is symlinked and available. Woot"
else
  echo "hdfs command is missing. Ouch. Try rebuilding the Docker containers. ./stop.sh && ./build.sh && start.sh"
  exit 0
fi

echo "creating signal2019 data paths"
hdfs dfs -mkdir /voiceinsights
hdfs dfs -mkdir /voiceinsights/signal2019
hdfs dfs -mkdir /voiceinsights/signal2019/data
hdfs dfs -ls /

echo "installing all signal data into hdfs"
hdfs dfs -put /signaldata/* /voiceinsights/signal2019/data
hdfs dfs -ls /voiceinsights/signal2019/data/

#checkInstall
#createSignalFilePaths
#importAllFiles
