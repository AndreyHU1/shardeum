#!/bin/bash
sudo apt update
sudo apt install docker.io -y
sudo apt install expect -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
sudo curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh
sudo curl -O https://raw.githubusercontent.com/AndreyHU1/shardeum/main/auto.exp && chmod +x auto.exp
sudo curl -O https://raw.githubusercontent.com/AndreyHU1/shardeum/main/status.sh && chmod +x status.sh
sudo curl -O https://raw.githubusercontent.com/AndreyHU1/shardeum/main/update.sh && chmod +x update.sh
sudo expect auto.exp $1
sudo docker exec shardeum-dashboard operator-cli start
sleep 5
sudo bash status.sh #sudo ./status.sh
(crontab -l; echo "0 * * * * bash update.sh >> /root/cron.log") | crontab -
(crontab -l; echo "45 * * * * curl -O https://raw.githubusercontent.com/AndreyHU1/shardeum/main/update.sh >> /root/cron.log") | crontab -
