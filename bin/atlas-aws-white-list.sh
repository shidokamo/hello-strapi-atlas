#!/bin/bash
# Create group of ip white list to avoid API rate limit violation
# Get JSON --> generate ip list --> Pass each 100 ips to sub command
wget -O - https://ip-ranges.amazonaws.com/ip-ranges.json \
|jq -r ".prefixes[].ip_prefix" \
|tr -s '\n' '\0' \
|xargs -0 -n 50 -t `dirname $0`/atlas-post-white-list.sh

