#!/bin/bash

# install elasticsearch
sudo apt -y update
sudo apt -y install apt-transport-https openjdk-8-jre-headless
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get -y update && sudo apt-get -y install elasticsearch
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service

# install kibana
sudo apt-get -y install kibana
sudo systemctl enable kibana
sudo systemctl start kibana

# test elasticsearch run
curl -XGET 'localhost:9200/?pretty'