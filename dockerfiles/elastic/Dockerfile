FROM ubuntu

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get install -y openssh-client openssh-server openjdk-8-jdk-headless wget apt-transport-https curl gnupg2 apt-utils

WORKDIR /home

COPY elasticsearch-installer.sh elasticsearch-installer.sh
COPY run.sh run.sh

RUN ./elasticsearch-installer.sh

EXPOSE 9200 9300 5601

COPY modified_settings/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
COPY modified_settings/kibana.yml /etc/kibana/kibana.yml

RUN bash -c "source ~/.bashrc"

ENTRYPOINT ["./run.sh"] 

# sudo docker build --tag elastic .
# sudo docker run -d -it --rm -p 9300:9300 -p 9200:9200 -p 5601:5601 --name elastic elastic 
# sudo docker exec -it elastic bash

