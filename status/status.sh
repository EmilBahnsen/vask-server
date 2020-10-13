#!/bin/bash

local_path=$(dirname "$0")
#read -p 'Username: ' username
#read -sp 'Password: ' password

username=$1
password=$2

token=$(curl --data "scope=DA" --data "client_id=YV1ZAQ7BTE9IT2ZBZXLJ" --data "username="$username --data "password="$password --data "grant_type=password" -X POST https://sec.mielelogic.com/v3/token | jq -r '.access_token')
# echo $token

curl -H "Authorization: Bearer "$token https://api.mielelogic.com/v3/Country/DA/Laundry/9894/laundrystates?language=en > $local_path/status1.json
curl -H "Authorization: Bearer "$token https://api.mielelogic.com/v3/Country/DA/Laundry/9893/laundrystates?language=en > $local_path/status2.json

# cat $local_path/status1.json
# cat $local_path/status2.json

# Append to status history
timestamp=$(date +'%Y-%m-%d %T')
last_record=$(tail -n 1 history.txt | cut -c 20- || echo '')

record=$(python3 $local_path/makeRecord.py $local_path/status1.json $local_path/status2.json)
echo $last_record
echo $record

# Don't rocord if nothing has changed
if [[ "$last_record" == "$record" ]]; then
	echo exit
	exit
fi

echo $timestamp$record >> history.txt
