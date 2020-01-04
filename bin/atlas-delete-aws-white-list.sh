#!/bin/bash
# Remove EC2 IP white list for specified heroku US AWS region
#
# TODO: it's better to update it to get ip list from Atlas and use it as delete request

for region in "us-east-1" "us-west-2"; do
  # Get US EC2 ip range ("/" should be replaced with %2F in DELETE request)
  ips=$(
    wget -O - https://ip-ranges.amazonaws.com/ip-ranges.json \
    |jq --arg region "$region" -r '.prefixes[] | select(.region==$region) | select(.service=="EC2") | .ip_prefix | sub("/"; "%2F")' \
    |sort
  )

  # You might need to add wait time for the API call
  for ip in $ips; do
    curl --user "${ATLAS_PUBLIC_KEY}:${ATLAS_PRIVATE_KEY}" --digest --include \
         --header "Accept: application/json" \
         --header "Content-Type: application/json" \
         --request DELETE "https://cloud.mongodb.com/api/atlas/v1.0/groups/${ATLAS_PROJECT_ID}/whitelist/${ip}?pretty=true"
  done
done
  
