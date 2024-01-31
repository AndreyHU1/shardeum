#!/bin/bash
curl -O https://github.com/AndreyHU1/shardeum/blob/26c708ebcfcfb27db5f45ae8d3c089f835f4db04/auto_temp.exp && chmod +x auto_temp.exp
sudo expect auto_temp.exp
sudo docker exec shardeum-dashboard operator-cli start
sleep 5
sudo bash status.sh #sudo ./status.sh
