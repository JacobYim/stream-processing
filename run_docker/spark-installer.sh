#!/bin/bash

wget http://archive.apache.org/dist/spark/spark-2.2.2/spark-2.2.2-bin-hadoop2.7.tgz -O /opt/spark.tar.gz
tar -zxvf /opt/spark.tar.gz -C /opt/
chown -R user:user /opt
chown -R user:user /opt/spark-2.2.2-bin-hadoop2.7  

SPARK_HOME=/opt/spark-2.2.2-bin-hadoop2.7

if grep -Fxq 'export SPARK_HOME="'$SPARK_HOME'"' ~/.bashrc 
then 
    echo "already SPARK_HOME was registered"
else 
    echo 'export SPARK_HOME="'$SPARK_HOME'"' >> ~/.bashrc
    echo 'export PATH=$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH' >> ~/.bashrc
    echo "SPARK_HOME was registered"
fi

cp ../modified_setting/spark-env.sh /opt/spark-2.2.2-bin-hadoop2.7/conf/spark-env.sh
cp ../modified_setting/spark-defaults.conf /opt/spark-2.2.2-bin-hadoop2.7/conf/spark-defaults.conf

# start-master.sh
# start-slaves.sh