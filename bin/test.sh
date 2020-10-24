#!/bin/bash
echo 'check jq from choco'
$choco list -li | grep -i jq

echo 'get token from /auth'
export TOKEN=`curl -d '{"email":"abc@example.com","password":"123abc"}' -H "Content-Type: application/json" -X POST localhost:8080/auth  | jq -r '.token'`
echo $TOKEN

echo 'get auth content'
curl --request GET 'http://127.0.0.1:8080/contents' -H "Authorization: Bearer ${TOKEN}" | jq .
