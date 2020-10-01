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
