#!/bin/bash

#must run from root

sudo apt-get update -y
sudo apt-get upgrade -y

# InfluxDB v2 install
curl --silent --location -O \
https://repos.influxdata.com/influxdata-archive.key
echo "943666881a1b8d9b849b74caebf02d3465d6beb716510d86a39f6c8e8dac7515  influxdata-archive.key" \
| sha256sum --check - && cat influxdata-archive.key \
| gpg --dearmor \
| tee /etc/apt/trusted.gpg.d/influxdata-archive.gpg > /dev/null \
&& echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive.gpg] https://repos.influxdata.com/debian stable main' \
| tee /etc/apt/sources.list.d/influxdata.list
sudo apt-get update && sudo apt-get install influxdb2 -y
sudo systemctl unmask influxdb
sudo service influxdb start

#Mosquitto install
sudo apt-get install -y mosquitto
sudo systemctl start mosquitto


# Grafana install
sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

sudo apt-get update -y
sudo apt-get install -y grafana

sudo systemctl daemon-reload
sudo systemctl enable grafana
sudo systemctl start grafana

# node-red and NodeJS
bash <(curl -fsSL https://deb.nodesource.com/setup_23.x -o nodesource_setup.sh)
sudo -E bash nodesource_setup.sh
sudo apt-get install -y nodejs

bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
sudo systemctl enable nodered
sudo systemctl start nodered
