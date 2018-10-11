#!/bin/sh -eu

export DEBIAN_NONINTERACTIVE=yes

# Register Docker CE repository key
wget -q -O- https://download.docker.com/linux/debian/gpg | apt-key add -

# Register Docker repository
codename=$(lsb_release -cs)

cat > /etc/apt/sources.list.d/docker-ce.list << END
deb [arch=amd64] https://download.docker.com/linux/debian ${codename} stable
END

# Install Docker
apt-get update -qq
apt-get install -qq -y docker-ce

# Enable docker service
systemctl enable docker
