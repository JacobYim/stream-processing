FROM ubuntu

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update
RUN apt-get install -y openssh-client openssh-server openjdk-8-jdk-headless wget apt-transport-https curl gnupg2 apt-utils

WORKDIR /home

COPY postgresql-installer.sh postgresql-installer.sh
COPY run.sh run.sh

RUN ./postgresql-installer.sh

EXPOSE 5432

COPY modified_settings/pg_hba.conf /etc/postgresql/13/main/pg_hba.conf
RUN bash -c "source ~/.bashrc"
RUN sed -e "s/[#]\?listen_addresses = .*/listen_addresses = '*'/g" -i '/etc/postgresql/13/main/postgresql.conf'

ENTRYPOINT ["./run.sh"] 

# sudo docker build --tag postgresql .
# sudo docker run -d -it --rm -p 5432:5432  -v postgres-data:/var/lib/postgresql/data --name postgresql postgresql 
# sudo docker exec -it postgresql bash

# conn = psycopg2.connect(database="test", user="root", password="1q2w3e4r", host="localhost", port="5432")