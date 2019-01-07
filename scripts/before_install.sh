#!/usr/bin/env bash

# Install
apt-add-repository --yes ppa:ansible/ansible
apt update
apt install --yes --no-install-recommends ansible software-properties-common

