#!/bin/bash

sudo wget http://archive.apache.org/dist/spark/spark-2.2.2/spark-2.2.2-bin-hadoop2.7.tgz -O /opt/spark.tar.gz
sudo tar -zxvf /opt/spark.tar.gz -C /opt/
sudo chown -R user:user /opt/
sudo chown -R user:user /opt/spark-2.2.2-bin-hadoop2.7/  

sudo echo 'export SPARK_HOME=/opt/spark-2.2.2-bin-hadoop2.7' >> ~/.bashrc
sudo echo 'export PATH=$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH' >> ~/.bashrc

sudo cp ../modified_setting/spark-env.sh /opt/spark-2.2.2-bin-hadoop2.7/conf/spark-env.sh
sudo cp ../modified_setting/spark-defaults.conf /opt/spark-2.2.2-bin-hadoop2.7/conf/spark-defaults.conf

source ~/.bashrc

# start-master.sh
# start-slaves.sh