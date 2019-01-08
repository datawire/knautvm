#!/usr/bin/env bash

# install.sh
# =================
#
# Perform installation of components
#

set -o errexit
set -o nounset
set -o verbose

ansible-playbook --connection=local --inventory=127.0.0.1 ansible/playbook.yaml
