#!/bin/bash
# Create JSON string for ip white list to avoid rate limit violation

# Get JSON --> generate ip list --> Pass each 100 ips to sub command
wget -O - https://ip-ranges.amazonaws.com/ip-ranges.json \
|jq -r ".prefixes[].ip_prefix" \
|tr -s '\n' '\0' \
|xargs -0 -n 10 -t `dirname $0`/atlas-post-white-list.sh

#  curl -X POST -u "${ATLAS_PUBLIC_KEY}:${ATLAS_PRIVATE_KEY}" --digest "https://cloud.mongodb.com/api/atlas/v1.0/groups/${ATLAS_PROJECT_ID}?pretty=true"
#  curl --user "${ATLAS_PUBLIC_KEY}:${ATLAS_PRIVATE_KEY}" --digest --include \
#       --header "Accept: application/json" \
#       --header "Content-Type: application/json" \
#       --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/${ATLAS_PROJECT_ID}/whitelist?pretty=true" \
#       --data $(jq -n --arg ip $ip --arg comment "AWS IP range @ $(date -I)" '[{"cidrBlock": $ip, "comment": $comment}]')
#  sleep 1
# done
