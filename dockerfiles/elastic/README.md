# Elasticsearch docker 

## How to run
```
sudo docker build --tag elastic .
sudo docker run -d -it --rm -p 9300:9300 -p 9200:9200 -p 5601:5601 --name elastic elastic 
```

## How to enter container
```
sudo docker exec -it elastic bash
```

## How to connect with python
```
! pip install elasticsearch


```
