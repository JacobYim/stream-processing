#!/bin/bash

/etc/init.d/postgresql start
/etc/init.d/elasticsearch start
/etc/init.d/kibana start

/etc/init.d/ssh start 
hdfs namenode -format &
start-dfs.sh &
start-yarn.sh &

start-master.sh &
start-slaves.sh &

# start zookeeper
zookeeper-server-start $CONFLUENT_HOME/etc/kafka/zookeeper.properties &
# start kafka
kafka-server-start $CONFLUENT_HOME/etc/kafka/server.properties &
# start schema-registry
schema-registry-start $CONFLUENT_HOME/etc/schema-registry/schema-registry.properties &
# start connectors
# connect-distributed $CONFLUENT_HOME/etc/schema-registry/connect-avro-distributed.properties &
connect-standalone $CONFLUENT_HOME/etc/schema-registry/connect-avro-standalone.properties \
    # $CONFLUENT_HOME/etc/kafka-connect-elasticsearch/quickstart-elasticsearch.properties \
    # $CONFLUENT_HOME/etc/kafka-connect-jdbc/sink-quickstart-sqlite.properties


jps &

bash