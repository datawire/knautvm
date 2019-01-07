#!/usr/bin/env bash

# before_install.sh
# =================
#
# Perform essential pre-installation work.
#

set -o errexit
set -o nounset
set -o verbose

apt-add-repository --yes ppa:ansible/ansible
apt update
apt install --yes --no-install-recommends \
    ansible \
    software-properties-common
