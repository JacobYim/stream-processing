#!/bin/bash

apt-get install -y openssh-client openssh-server openjdk-8-jdk-headless wget
JAVA_PATH=$(readlink -f /usr/bin/java | sed "s:bin/java::")
HADOOP_PATH='/opt/hadoop-2.7.4/'

# ssh-keygen -t rsa -P ""
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y 2>&1 >/dev/null
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
chmod og-wx $HOME/.ssh/authorized_keys
/etc/init.d/ssh start 
ssh -o "StrictHostKeyChecking no" localhost
ssh -o "StrictHostKeyChecking no" 0.0.0.0

wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.4/hadoop-2.7.4.tar.gz -O /opt/hadoop.tar.gz
tar -zxvf /opt/hadoop.tar.gz -C /opt/

if grep -Fxq 'export JAVA_HOME="'$JAVA_PATH'"' ~/.bashrc 
then 
    echo "already JAVA_HOME was registered"
else 
    echo 'export JAVA_HOME="'$JAVA_PATH'"' >> ~/.bashrc
    echo "JAVA_HOME was registered"
fi

if grep -Fxq 'export HADOOP_HOME="'$HADOOP_PATH'"' ~/.bashrc 
then 
    echo "already HADOOP_PATH was registered"
else 
    echo 'export HADOOP_HOME="'$HADOOP_PATH'"' >> ~/.bashrc
    echo 'export HADOOP_INSTALL=$HADOOP_HOME' >> ~/.bashrc
    echo 'export HADOOP_MAPRED_HOME=$HADOOP_HOME' >> ~/.bashrc
    echo 'export HADOOP_COMMON_HOME=$HADOOP_HOME' >> ~/.bashrc
    echo 'export HADOOP_HDFS_HOME=$HADOOP_HOME' >> ~/.bashrc
    echo 'export YARN_HOME=$HADOOP_HOME' >> ~/.bashrc
    echo 'export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native' >> ~/.bashrc
    echo 'export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin' >> ~/.bashrc
    echo 'export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"' >> ~/.bashrc

    echo 'export PATH="$PATH:$HADOOP_HOME/sbin/"'>> ~/.bashrc

    echo "HADOOP_HOME was registered"
fi

source ~/.bashrc

cp ../modified_setting/*.xml $HADOOP_PATH/etc/hadoop/
cp ../modified_setting/hadoop-env.sh $HADOOP_PATH/etc/hadoop/hadoop-env.sh
    
# /etc/init.d/ssh start 
# hdfs namenode -format
# ./start-dfs.sh &
# ./start-yarn.sh &
# jps &

# # http://localhost:9870


# sudo useradd hadoop
# sudo passwd hadoop

# su - hadoop 
# ssh-keygen -t rsa
# cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

