#!/bin/bash

# fail on error
set -e

# =============================================================================================
echo "downloading minio client ..."
wget https://dl.minio.io/client/mc/release/linux-amd64/mc -O mc
chmod +x mc

echo "downloading jq ..."
wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O jq
chmod +x jq
