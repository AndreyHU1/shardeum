#!/bin/bash
curl -O https://raw.githubusercontent.com/AndreyHU1/shardeum/main/auto_temp.exp && chmod +x auto_temp.exp
sudo expect auto_temp.exp
sudo docker exec shardeum-dashboard operator-cli start
sleep 5
sudo bash status.sh #sudo ./status.sh
