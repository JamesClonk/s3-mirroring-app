#!/bin/bash

# fail on error
set -e

# =============================================================================================
echo "parsing VCAP_SERVICES, looking for [${SOURCE_SERVICE_NAME}] and [${TARGET_SERVICE_NAME}] ..."
export SOURCE_CREDENTIALS=$(echo ${VCAP_SERVICES} | ./jq '.. | select(.name? == "'${SOURCE_SERVICE_NAME}'") | .credentials')
export SOURCE_HOST=$(echo ${SOURCE_CREDENTIALS} | ./jq -r '.accessHost')
export SOURCE_KEY=$(echo ${SOURCE_CREDENTIALS} | ./jq -r '.accessKey')
export SOURCE_SECRET=$(echo ${SOURCE_CREDENTIALS} | ./jq -r '.sharedSecret')
export TARGET_CREDENTIALS=$(echo ${VCAP_SERVICES} | ./jq '.. | select(.name? == "'${TARGET_SERVICE_NAME}'") | .credentials')
export TARGET_HOST=$(echo ${TARGET_CREDENTIALS} | ./jq -r '.accessHost')
export TARGET_KEY=$(echo ${TARGET_CREDENTIALS} | ./jq -r '.accessKey')
export TARGET_SECRET=$(echo ${TARGET_CREDENTIALS} | ./jq -r '.sharedSecret')

# =============================================================================================
echo "writing mc-config ..."
echo '{
	"version": "9",
	"hosts": {
		"source": {
			"url": "https://'${SOURCE_HOST}'",
			"accessKey": "'${SOURCE_KEY}'",
			"secretKey": "'${SOURCE_SECRET}'",
			"api": "S3v4",
			"lookup": "auto"
		},
		"target": {
			"url": "https://'${TARGET_HOST}'",
			"accessKey": "'${TARGET_KEY}'",
			"secretKey": "'${TARGET_SECRET}'",
			"api": "S3v4",
			"lookup": "auto"
		}
	}
}' > config.json

# =============================================================================================
echo "mirroring buckets ..."
while true; do
	./mc -C . mirror --overwrite -a source/ target/
	sleep 600
done
