#!/bin/bash

ROOT_TOKEN=`cat /vault/data/key.txt | grep -e "Root Token:.*" -o | cut -f3 -d' '`
#declare -A UNSEAL_KEY
UNSEAL_KEY=(`cat /vault/data/key.txt | grep -e "Unseal Key.*" -o | cut -f4 -d' '`)

num=0
while [ $num -le 4 ]
do
jsonvariable=${UNSEAL_KEY[$num]}
object='{"key": "'"$jsonvariable"'"}'
curl -k -H "Content-Type: application/json" -XPUT http://localhost:8200/v1/sys/unseal -d "$object"
let num++
done

# Login with root token
vault login $ROOT_TOKEN
