#!/bin/bash
# Remove IP white list for specified AWS region

region=$1

# Remove all existing AWS ips ("/" should be replaced with %2F in DELETE request)
ips=$(
  wget -O - https://ip-ranges.amazonaws.com/ip-ranges.json \
  |jq --arg region "$region" -r '.prefixes[] | select(.region==$region) | .ip_prefix | sub("/"; "%2F")' \
  |sort
)

# You might need to add wait time for the API call
for ip in $ips; do
  curl --user "${ATLAS_PUBLIC_KEY}:${ATLAS_PRIVATE_KEY}" --digest --include \
       --header "Accept: application/json" \
       --header "Content-Type: application/json" \
       --request DELETE "https://cloud.mongodb.com/api/atlas/v1.0/groups/${ATLAS_PROJECT_ID}/whitelist/${ip}?pretty=true"
done

