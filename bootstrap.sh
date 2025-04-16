#!/bin/bash

# Export JAVA_HOME for the current shell
export JAVA_HOME=/usr/local/openjdk-8

# Start SSH first
echo "Starting SSH..."
service ssh start

# Format Namenode if not formatted
if [ ! -f /opt/hadoop/data/dfs/name/current/VERSION ]; then
    echo "Formatting NameNode..."
    hdfs namenode -format -force
fi

# Source Hadoop environment variables from hadoop-env.sh
if [ -f "$HADOOP_HOME/etc/hadoop/hadoop-env.sh" ]; then
    echo "Sourcing hadoop-env.sh..."
    source "$HADOOP_HOME/etc/hadoop/hadoop-env.sh"
    echo "JAVA_HOME after sourcing: $JAVA_HOME"
else
    echo "ERROR: $HADOOP_HOME/etc/hadoop/hadoop-env.sh not found."
fi

# Start Hadoop services
echo "Starting Hadoop services..."
start-dfs.sh

# Optional: Add a delay to allow NameNode to bind to port 9000
sleep 10

# Wait for HDFS to become available
echo "Waiting for HDFS startup..."
until hdfs dfsadmin -safemode wait | grep "Safe mode is OFF"; do
    sleep 5
done

# Start YARN
start-yarn.sh

# Verify services
jps | grep -E 'NameNode|DataNode|ResourceManager|NodeManager'

# Keep container running
tail -f /dev/null
