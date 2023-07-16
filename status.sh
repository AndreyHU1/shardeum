#!/root/bin/bash
#set timeout -1
channel_id=$(awk '/shardeum_channel_id:/ {print $NF}' config);
tg_bot_token=$(awk '/tg_bot_token:/ {print $NF}' config);
node_name=$(awk '/node_name:/ {print $NF}' config);

docker exec -it shardeum-dashboard operator-cli status > status.txt
status=$(awk '/state:/ {print $NF}' status.txt | sed 's/.$//');
staked=$(awk '/lockedStake:/ {print $NF}' status.txt);
earn=$(awk '/currentRewards:/ {print $NF}' status.txt);
version=$(awk '/shardeumVersion:/ {print $NF}' status.txt);
echo "Captain Bob, I'm starting to check node.01 !";
echo "Node status: $status";
echo "Staked: $staked";
echo "Earn: $earn";
echo "Version: $version";


if [[ $status == *"tandb"* ]]; then 
	curl -F chat_id="$channel_id" -F text="✅ $node_name: $status | Staked: $staked | Earn: $earn | Ver: $version" https://api.telegram.org/bot"$tg_bot_token"/sendMessage
else
	curl -F chat_id="$channel_id" -F text="❌ $node_name: $status | Staked: $staked | Earn: $earn | Ver: $version" https://api.telegram.org/bot"$tg_bot_token"/sendMessage
fi
