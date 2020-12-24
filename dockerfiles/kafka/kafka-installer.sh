#!/bin/bash

apt-get -y update
apt-get -y install apt-transport-https openjdk-8-jre-headless
wget http://packages.confluent.io/archive/5.5/confluent-5.5.0-2.12.tar.gz -O /opt/confluent.tar.gz
tar -zxvf /opt/confluent.tar.gz -C /opt/

if grep -Fxq 'export CONFLUENT_HOME="/opt/confluent-5.5.0"' ~/.bashrc 
then 
    echo "already CONFLUENT_HOME_PATH was registered"
else 
    echo 'export CONFLUENT_HOME="/opt/confluent-5.5.0"' >> ~/.bashrc
    export CONFLUENT_HOME="/opt/confluent-5.5.0"
    echo "CONFLUENT_HOME was registered"
fi

if grep -Fxq 'export PATH="$PATH:$CONFLUENT_HOME/bin/"' ~/.bashrc 
then 
    echo "already CONFLUENT_PATH was registered"
else 
    echo 'export PATH="$PATH:$CONFLUENT_HOME/bin/"' >> ~/.bashrc
    export PATH="$PATH:$CONFLUENT_HOME/bin/"
    echo "CONFLUENT_PATH was registered"
fi

source ~/.bashrc

cp ../modified_setting/connect-avro-distributed.properties $CONFLUENT_HOME/etc/schema-registry/connect-avro-distributed.properties
cp ../modified_setting/connect-avro-standalone.properties  $CONFLUENT_HOME/etc/schema-registry/connect-avro-standalone.properties
cp ../modified_setting/sink-quickstart-sqlite.properties   $CONFLUENT_HOME/etc/kafka-connect-jdbc/sink-quickstart-sqlite.properties
cp ../modified_setting/source-quickstart-sqlite.properties $CONFLUENT_HOME/etc/kafka-connect-jdbc/source-quickstart-sqlite.properties
cp ../modified_setting/quickstart-elasticsearch.properties $CONFLUENT_HOME/etc/kafka-connect-elasticsearch/quickstart-elasticsearch.properties

# # start zookeeper
# zookeeper-server-start $CONFLUENT_HOME/etc/kafka/zookeeper.properties &
# # start kafka
# kafka-server-start $CONFLUENT_HOME/etc/kafka/server.properties &
# # start schema-registry
# schema-registry-start $CONFLUENT_HOME/etc/schema-registry/schema-registry.properties &
# # start connectors
# # connect-distributed $CONFLUENT_HOME/etc/schema-registry/connect-avro-distributed.properties &
# connect-standalone $CONFLUENT_HOME/etc/schema-registry/connect-avro-standalone.properties \
#     # $CONFLUENT_HOME/etc/kafka-connect-elasticsearch/quickstart-elasticsearch.properties \
#     # $CONFLUENT_HOME/etc/kafka-connect-jdbc/sink-quickstart-sqlite.properties

