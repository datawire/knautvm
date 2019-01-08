#!/usr/bin/env bash

# before_install.sh
# =================
#
# Perform essential pre-installation work.
#

set -o errexit
set -o nounset
set -o verbose

# Install the apt-add-repository command
apt update
apt install --yes --no-install-recommends software-properties-common

# Install Ansible
apt-add-repository --yes ppa:ansible/ansible
apt install --yes --no-install-recommends ansible

