# Postgresql docker 

## How to run
```
sudo docker build --tag postgresql .
sudo docker run -d -it --rm -p 5432:5432  -v postgres-data:/var/lib/postgresql/data --name postgresql postgresql 
```

## How to enter container
```
sudo docker exec -it postgresql bash
```

## How to connect with python
```
! pip install psycopg2-binary

import psycopg2
conn = psycopg2.connect(database="test", user="root", password="1q2w3e4r", host="localhost", port="5432")
```
