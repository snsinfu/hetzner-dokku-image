#!/bin/sh -eu

export DEBIAN_NONINTERACTIVE=yes

# Register packagecloud repository key
wget -q -O- https://packagecloud.io/gpg.key | apt-key add -

# Register Dokku repository
codename=$(lsb_release -cs)

cat > /etc/apt/sources.list.d/dokku.list << END
deb https://packagecloud.io/dokku/dokku/debian/ ${codename} main
END

# Pre-configure Dokku
debconf-set-selections << END
dokku dokku/web_config boolean false
dokku dokku/vhost_enable boolean true
dokku dokku/hostname string dokku.me
dokku dokku/skip_key_file boolean true
dokku dokku/key_file string /root/.ssh/id_rsa.pub
END

# Install Dokku
apt-get update -qq
apt-get install -qq -y dokku

# Install Plugins
dokku plugin:install-dependencies --core

dokku plugin:install "https://github.com/dokku/dokku-letsencrypt.git" letsencrypt
dokku plugin:install "https://github.com/dokku/dokku-postgres.git" postgres
dokku plugin:install "https://github.com/dokku/dokku-mongo.git" mongo
dokku plugin:install "https://github.com/dokku/dokku-redis.git" redis
dokku plugin:install "https://github.com/dokku/dokku-rabbitmq.git" rabbitmq
dokku plugin:install "https://github.com/dokku/dokku-elasticsearch.git" elasticsearch

# Disable default nginx site
rm -f /etc/nginx/sites-enabled/default

# Block request to nonexistent vhost
cp /tmp/assets/nginx_default_vhost.conf /etc/nginx/conf.d/00-default_vhost.conf
