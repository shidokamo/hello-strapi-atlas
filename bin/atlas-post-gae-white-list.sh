#!/bin/bash

# Add GAE ip rage to white list
includes=`nslookup -q=TXT _cloud-netblocks.googleusercontent.com 8.8.8.8 | tr ' ' '\n' | grep include | sed "s/include:\(.*\)/\1/g"`
for include in $includes; do
  ips=$(nslookup -q=TXT $include 8.8.8.8 | tr ' ' '\n' | grep ip4 | sed "s/ip[4,6]:\(.*\)/\1/g")
  echo "$ips"
  json=$(jq -n --arg ips "$ips" '$ips | split("\n") | map(split(" ")) | map({"cidrBlock": .[0], "comment": "GAE"})')
  echo "$json" | jq
  curl --user "${ATLAS_PUBLIC_KEY}:${ATLAS_PRIVATE_KEY}" --digest --include \
       --header "Accept: application/json" \
       --header "Content-Type: application/json" \
       --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/${ATLAS_PROJECT_ID}/whitelist?pretty=true" \
       --data "$json"
done
