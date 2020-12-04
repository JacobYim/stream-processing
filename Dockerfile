FROM ubuntu

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get install -y openssh-client openssh-server openjdk-8-jdk-headless wget

WORKDIR /home

COPY modified_setting modified_setting
COPY run_docker run_docker

RUN cd run_docker && ./hadoop-installer.sh && ./spark-installer.sh
# RUN cd run_docker && ./spark-installer.sh

RUN bash -c "source ~/.bashrc"
