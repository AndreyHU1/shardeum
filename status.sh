#!/root/bin/bash
channel_id=$(awk '/shardeum_channel_id:/ {print $NF}' config);
tg_bot_token=$(awk '/tg_bot_token:/ {print $NF}' config);
node_name=$(awk '/node_name:/ {print $NF}' config);
time_now=$(date)

docker exec -t shardeum-dashboard operator-cli status > status.txt
status=$(awk '/state:/ {print $NF}' status.txt | sed 's/.$//');
staked=$(awk '/lockedStake:/ {print $NF}' status.txt);
earn=$(awk '/currentRewards:/ {print $NF}' status.txt);
version=$(awk '/shardeumVersion:/ {print $NF}' status.txt);

echo ""
echo ""
echo "*** $time_now ***"
echo "Captain Bob, I'm starting to check $node_name!";
echo "Node status: $status";
echo "Staked: $staked";
echo "Earn: $earn";
echo "Version: $version";

for (( i=0; i<5; i++)); do
	echo "$i"
	if ((i>0)); then 
		echo "sleep 10sec";
		sleep 30;
		docker exec -t shardeum-dashboard operator-cli status > status.txt
		status=$(awk '/state:/ {print $NF}' status.txt | sed 's/.$//');
		staked=$(awk '/lockedStake:/ {print $NF}' status.txt);
		earn=$(awk '/currentRewards:/ {print $NF}' status.txt);
	fi
	
	if [[ $status == *"tandb"* ]]; then 
		curl -F chat_id="$channel_id" -F text="✅ $node_name: $status | Staked: $staked | Earn: $earn | Ver: $version" https://api.telegram.org/bot"$tg_bot_token"/sendMessage;
		if [[ $staked == "'0.0"* ]]; then # тут нужно проверять, как будет работать неэкранированная кавычка
			echo "zero staking"
		else
			i=10;
		fi
	else
		if [[ $status == *"ctiv"* ]]; then
			curl -F chat_id="$channel_id" -F text="⭐️ $node_name: $status | Staked: $staked | Earn: $earn | Ver: $version" https://api.telegram.org/bot"$tg_bot_token"/sendMessage;
			sleep 120;
			i=0;
		else	
			if [[ $status == *"toppe"* ]]; then 
				curl -F chat_id="$channel_id" -F text="⛔️ $node_name: $status | Staked: $staked | Earn: $earn | Ver: $version" https://api.telegram.org/bot"$tg_bot_token"/sendMessage;
				docker exec -t shardeum-dashboard operator-cli start;
				sleep 20;
			else
				curl -F chat_id="$channel_id" -F text="❌ $node_name: $status | Staked: $staked | Earn: $earn | Ver: $version" https://api.telegram.org/bot"$tg_bot_token"/sendMessage;
			fi
		fi
	fi
done
