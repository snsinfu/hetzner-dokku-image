# Dokku image on Hetzner cloud

Packer template for a Debian Dokku image on Hetzner cloud.

```
export HCLOUD_TOKEN=...
export HCLOUD_LOCATION=fsn1
export HCLOUD_TYPE=cx11

make
make clean
```

Deploying the image creates a Dokku server with virtual host name set to the
machine name and dokku ssh key set to the host-associated key. The server
becomes immutable. You can only operate on the `dokku` command with dokku user
previleges; no additional plugins can be installed.

TODO: Migrating state from previous Dokku installation.
