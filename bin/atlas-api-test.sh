#!/bin/sh
curl -X GET -u "${ATLAS_PUBLIC_KEY}:${ATLAS_PRIVATE_KEY}" --digest "https://cloud.mongodb.com/api/atlas/v1.0/groups/${ATLAS_PROJECT_ID}?pretty=true"

