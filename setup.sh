#!/bin/bash

# fail on error
set -e

# =============================================================================================
echo "downloading minio client ..."
wget https://dl.minio.io/client/mc/release/linux-amd64/mc -O mc
chmod +x mc
