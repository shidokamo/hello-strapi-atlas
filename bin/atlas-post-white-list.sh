#!/bin/bash
printf "$*" | jq --slurp -s -R 'split(" ") | map(split(" ")) | map({"ip": .[0]})'
