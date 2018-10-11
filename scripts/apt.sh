#!/bin/sh -eu

export DEBIAN_NONINTERACTIVE=true

# Upgrade system
apt-get update -qq
apt-get upgrade -qq -y
apt-get autoremove -qq -y

# Install third-party repository requirements
apt-get install -qq -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common
