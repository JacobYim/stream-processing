# stream-processing

## pre-requestlist
```
apt-get install curl
```


## install postgresql
run `postgresql-installer.sh`
```
./postgresql-installer.sh
```

test with code below :
```
sudo su - postgres
psql
```

[ref] https://phoenixnap.com/kb/how-to-install-postgresql-on-ubuntu


# install elasticsearch



# install docker
### how to use docker without sudo command 
to change docker socket permissions,
```
sudo setfacl -m user:$USER:rw /var/run/docker.sock
```

# install hadoop

[ref]https://phoenixnap.com/kb/install-hadoop-ubuntu

# install spark

[ref] https://glow153.tistory.com/16
[ref] https://dorongee.tistory.com/3?category=689596
# install kafka

## sink test
```
# elasticsearch 
kafka-avro-console-producer --broker-list localhost:9092 --topic table2 --property value.schema='{"type":"record","name":"myrecord","fields":[{"name":"f1","type":"string"}]}'

{"f1":"ssss"}

# postgres
kafka-avro-console-producer --broker-list localhost:9092 --topic table1 --property value.schema='{"type":"record","name":"myrecord","fields":[{"name":"id","type":"int"},{"name":"product","type":"string"},{"name":"quantity","type":"int"},{"name":"price","type":"float"}]}'

{"id":999,"product":"foo","quantity":100,"price":50}
```

[Notice] when changing schema,
'''
curl -X PUT http://localhost:8081/config/table1-value -d '{"compatibility":"NONE"}' -H "Content-Type:application/json"
'''

## source test
```
# postgres
kafka-avro-console-consumer --bootstrap-server localhost:9092 --topic table1 --from-beginning
```



[ref]https://docs.confluent.io/3.3.0/installation/installing_cp.html



# take stream kafka to spark
```
pyspark --packages org.apache.spark:spark-streaming-kafka-0-8_2.11:2.2.3,org.apache.spark:spark-sql-kafka-0-10_2.11:2.2.3

import pyspark
from pyspark import RDD
from pyspark import SparkContext
from pyspark.streaming import StreamingContext
from pyspark.streaming.kafka import KafkaUtils
import json#Spark context details

#sc = SparkContext(appName="PythonSparkStreamingKafka")
ssc = StreamingContext(sc,2) #Creating Kafka direct stream

dks = KafkaUtils.createDirectStream(ssc, ["test"], {"metadata.broker.list":"localhost:9092"})

counts = dks.pprint()

ssc.start()

ssc.awaitTermination()

# producer 
kafka-console-producer --broker-list localhost:9092 --topic test

# 
kafka-topics --list --zookeeper localhost:2181

kafka-console-consumer --bootstrap-server localhost:9092 --topic mytopic --from-beginning

```

```
<!-- sc = SparkContext(appName='PythonStreamingQueue') -->
import pyspark
from pyspark import RDD
from pyspark import SparkContext
from pyspark.streaming import StreamingContext

ssc = StreamingContext(sc, 1)

# Create the queue through which RDDs can be pushed to
# a QueueInputDStream
rddQueue = []
for _ in range(5):
    rddQueue += [ssc.sparkContext.parallelize([j for j in range(1, 1001)], 10)]

# Create the QueueInputDStream and use it do some processing
inputStream = ssc.queueStream(rddQueue)
mappedStream = inputStream.map(lambda x: (x % 10, 1))
reducedStream = mappedStream.reduceByKey(lambda a, b: a + b)
reducedStream.pprint()

ssc.start()
time.sleep(6)
ssc.stop(stopSparkContext=True, stopGraceFully=True) 
```


[ref]https://medium.com/@sandeepkattepogu/streaming-data-from-apache-kafka-topic-using-apache-spark-2-4-5-and-python-4073e716bdca

# make dockerfile for kafka, hadoop and elasticsearch

```
sudo docker build --tag test .
sudo docker run -it --rm --net host --name test test bash
```
```
/etc/init.d/ssh start 
hdfs namenode -format
start-dfs.sh 
start-yarn.sh 
start-master.sh
start-slaves.sh

jps
```

```
sudo docker build --tag instance .
sudo docker run -it --rm -p 9200:9200 -p 9300:9300 -p 5601:5601 -p 5432:5432 -p 9092:9092 -p 4040:4040 -p 18080:18080 -p 18081:18081 -p 8020:8020 -p 50072:50072 -p 9000:9000 -p 50070:50070 -p 50470:50470 --name instance instance 

```