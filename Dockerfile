FROM openjdk:8-jdk

ARG HADOOP_VERSION=3.3.6

# Install dependencies
RUN apt-get update && apt-get install -y \
    ssh \
    openssh-server \
    openssh-client \
    build-essential \
    maven \
    libsnappy-dev \
    && rm -rf /var/lib/apt/lists/*

# Setup SSH
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys

# Install Hadoop
RUN curl -sL --retry 3 \
  "https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" \
  | tar -xz -C /opt/ \
  && mv "/opt/hadoop-${HADOOP_VERSION}" /opt/hadoop

# Environment variables
ENV HADOOP_HOME=/opt/hadoop
ENV JAVA_HOME=/usr/local/openjdk-8
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV YARN_RESOURCEMANAGER_USER=root
ENV YARN_NODEMANAGER_USER=root
ENV HADOOP_OPTS="-Djava.net.preferIPv4Stack=true -Xmx512m"

# Copy configuration files
COPY hadoop-config/ $HADOOP_HOME/etc/hadoop/

# Copy bootstrap script
COPY bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

COPY --chown=root:root config/workers $HADOOP_HOME/etc/hadoop/workers

# Create data and logs directories
RUN mkdir -p /opt/hadoop/data/dfs/{name,data} && \
    mkdir -p /opt/hadoop/logs

# Expose ports
EXPOSE 9870 8088 9864 9866 9000 22

ENTRYPOINT ["/bootstrap.sh"]