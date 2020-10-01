#!/bin/bash

# sudo apt-get -y update
# sudo apt-get -y upgrade
JAVA_PATH=$(readlink -f /usr/bin/java | sed "s:bin/java::")
HADOOP_PATH='/opt/hadoop-2.10.1/'
sudo wget http://apache.mirror.cdnetworks.com/hadoop/common/hadoop-2.10.1/hadoop-2.10.1.tar.gz -O /opt/hadoop.tar.gz
sudo tar -zxvf /opt/hadoop.tar.gz -C /opt/



# sudo apt-get remove -y openssh-client openssh-server
sudo apt-get install -y openssh-client openssh-server openjdk-8-jdk-headless


sudo mkdir -p /tmp/hadoop/tmpdata
sudo mkdir -p /mnt/hadoop/dfsdata

if grep -Fxq 'export JAVA_HOME="'$JAVA_PATH'"' ~/.bashrc 
then 
    echo "already JAVA_HOME was registered"
else 
    sudo echo 'export JAVA_HOME="'$JAVA_PATH'"' >> ~/.bashrc
    echo "JAVA_HOME was registered"
fi

if grep -Fxq 'export HADOOP_HOME="'$HADOOP_PATH'"' ~/.bashrc 
then 
    echo "already HADOOP_PATH was registered"
else 
    sudo echo 'export HADOOP_HOME="'$HADOOP_PATH'"' >> ~/.bashrc
    sudo echo 'export HADOOP_INSTALL=$HADOOP_HOME' >> ~/.bashrc
    sudo echo 'export HADOOP_MAPRED_HOME=$HADOOP_HOME' >> ~/.bashrc
    sudo echo 'export HADOOP_COMMON_HOME=$HADOOP_HOME' >> ~/.bashrc
    sudo echo 'export HADOOP_HDFS_HOME=$HADOOP_HOME' >> ~/.bashrc
    sudo echo 'export YARN_HOME=$HADOOP_HOME' >> ~/.bashrc
    sudo echo 'export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native' >> ~/.bashrc
    sudo echo 'export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin' >> ~/.bashrc
    sudo echo 'export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"' >> ~/.bashrc

    sudo echo 'export PATH="$PATH:$HADOOP_HOME/sbin/"'>> ~/.bashrc

    echo "HADOOP_HOME was registered"
fi

source ~/.bashrc 

sudo cp ../modified_setting/*.xml $HADOOP_HOME/etc/hadoop/
sudo cp ../modified_setting/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh
    



hdfs namenode -format

./start-dfs.sh &
./start-yarn.sh &
jps &
# http://localhost:9870