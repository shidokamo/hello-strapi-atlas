#!/bin/bash

json=$(
  wget -O - https://ip-ranges.amazonaws.com/ip-ranges.json \
  |jq -r '.prefixes[] | select(.region=| [{"cidrBlock": .ip_prefix, "comment": "AWS ip range"}]'
)
echo

# Create group of ip white list to avoid API rate limit violation
region=$1
# Get JSON --> generate ip list for specified region --> Pass each 100 ips to sub command
wget -O - https://ip-ranges.amazonaws.com/ip-ranges.json \
|jq --arg region ${region} -r '.prefixes[] | select(.region==$region) | .ip_prefix' \
|sort \
|tr -s '\n' '\0' \
|xargs -0 -n 50 -t `dirname $0`/atlas-post-white-list.sh

