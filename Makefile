.PHONY: all clean

all: manifest.json
	@:

clean:
	jq -r ".builds[].artifact_id" < manifest.json | xargs -L1 ./hcloud_remove_image.sh
	rm -f manifest.json

manifest.json: dokku.json assets/* scripts/*
	packer build dokku.json
