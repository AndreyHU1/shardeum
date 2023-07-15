#!/bin/bash
sudo apt install docker.io -y
sudo apt install expect -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh
sudo curl -O https://raw.githubusercontent.com/AndreyHU1/shardeum/main/auto.exp && chmod +x auto.exp
sudo expect auto.exp $1
sudo docker exec shardeum-dashboard operator-cli start
