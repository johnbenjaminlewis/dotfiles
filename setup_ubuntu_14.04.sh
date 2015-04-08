#!/bin/bash
# This script makes Ubuntu 14.04 work

# Run base installer
SOURCE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
$SOURCE_DIR/setup_ubuntu_base.sh
$SOURCE_DIR/setup_env.sh
