#!/bin/bash

# install elasticsearch
# sudo apt -y update
# sudo apt -y install apt-transport-https openjdk-8-jre-headless
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-6.x.list
apt-get -y update && apt-get -y install elasticsearch

# /etc/init.d/elasticsearch start
# install kibana
apt-get -y install kibana
# /etc/init.d/kibana start
# cp ../modified_setting/elastic/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
# cp ../modified_setting/elastic/kibana.yml /etc/kibana/kibana.yml
# test elasticsearch run
# curl -XGET 'localhost:9200/?pretty'