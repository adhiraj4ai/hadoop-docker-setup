#!/bin/bash

# Copy configs to shared volume if empty
if [ -z "$(ls -A /opt/hadoop/etc/hadoop)" ]; then
  cp -r /tmp/hadoop-config/* /opt/hadoop/etc/hadoop/
fi

# Original startup commands
hdfs namenode -format -force
start-dfs.sh
start-yarn.sh
tail -f /dev/null