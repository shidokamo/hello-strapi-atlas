#!/bin/bash
json=$(jq -n --arg ip "$*" '$ip | split(" ") | map(split(" ")) | map({"cidrBlock": .[0], "comment": "AWS ip range"})')
curl --user "${ATLAS_PUBLIC_KEY}:${ATLAS_PRIVATE_KEY}" --digest --include \
     --header "Accept: application/json" \
     --header "Content-Type: application/json" \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/${ATLAS_PROJECT_ID}/whitelist?pretty=true" \
     --data "$json"
