#!/bin/bash

for region in "us-east-1" "us-west-2"; do
  req_array=$(
    wget -O - https://ip-ranges.amazonaws.com/ip-ranges.json \
    |jq --arg region ${region} \
      '.prefixes[] | select(.region==$region) | select(.service=="EC2") | {cidrBlock: .ip_prefix, comment: "AWS EC2"}' \
    |jq -s '.'
  )
  curl --user "${ATLAS_PUBLIC_KEY}:${ATLAS_PRIVATE_KEY}" --digest --include \
       --header "Accept: application/json" \
       --header "Content-Type: application/json" \
       --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/${ATLAS_PROJECT_ID}/whitelist?pretty=true" \
       --data "$req_array"
done
