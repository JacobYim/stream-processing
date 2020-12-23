FROM ubuntu

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get install -y openssh-client openssh-server openjdk-8-jdk-headless wget apt-transport-https curl gnupg2 apt-utils

WORKDIR /home

COPY modified_setting modified_setting
COPY run_docker run_docker

RUN cd run_docker &&  ./elasticsearch-installer.sh && ./postgresql-installer.sh && ./hadoop-installer.sh && ./spark-installer.sh && ./kafka-installer.sh

EXPOSE 9200 9300 5601
EXPOSE 5432

EXPOSE 50075 8020 9000 50070 50470

EXPOSE 4040 18080 18081

EXPOSE 9092

# RUN cd run_docker && ./spark-installer.sh

RUN bash -c "source ~/.bashrc"

