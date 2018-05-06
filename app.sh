#!/bin/bash

# fail on error
set -e

# =============================================================================================
echo "mirroring buckets ..."
mc mirror --force --watch