#!/bin/bash

includes=`nslookup -q=TXT _cloud-netblocks.googleusercontent.com 8.8.8.8 | tr ' ' '\n' | grep include | sed "s/include:\(.*\)/\1/g"`
for include in $includes; do
  nslookup -q=TXT $include 8.8.8.8 | tr ' ' '\n' | grep ip4 | sed "s/ip[4,6]:\(.*\)/\1/g"
done
