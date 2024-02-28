#!/root/bin/bash
channel_id=$(awk '/shardeum_update_channel_id:/ {print $NF}' config);
tg_bot_token=$(awk '/tg_bot_token:/ {print $NF}' config);
node_name=$(awk '/node_name:/ {print $NF}' config);
docker exec -t shardeum-dashboard operator-cli status > status.txt
version=$(awk '/shardeumVersion:/ {print $NF}' status.txt)
sudo curl -O https://raw.githubusercontent.com/AndreyHU1/shardeum/main/status.sh

#if [[ 1 == 1 ]]; then
#if [[ $version != *".9.7"* && $version == *".9."* ]]; then
if [[ $version != *".10.1"* ]]; then
	sudo curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh
 	sudo curl -O https://raw.githubusercontent.com/AndreyHU1/shardeum/main/update.exp && chmod +x update.exp
	sudo expect update.exp
	docker exec -t shardeum-dashboard operator-cli start
	sleep 5
	docker exec -t shardeum-dashboard operator-cli status > status.txt
	version=$(awk '/shardeumVersion:/ {print $NF}' status.txt)
	curl -F chat_id="$channel_id" -F text="⭐️⭐️⭐️ $node_name: updated to version 🌵 $version 🌵 ⭐️⭐️⭐️" https://api.telegram.org/bot"$tg_bot_token"/sendMessage
fi 
