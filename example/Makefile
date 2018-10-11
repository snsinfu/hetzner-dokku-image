ARTIFACTS = \
  _init.ok \
  _server.ok \
  terraform.tfstate \
  terraform.tfstate.backup \
  sshkey \
  sshkey.pub

TF_ENVS = \
  TF_VAR_image_id=$$(jq -r ".builds[-1].artifact_id" < ../manifest.json)


.PHONY: all clean ssh

all: _server.ok
	@:

clean:
	$(TF_ENVS) terraform destroy -auto-approve
	rm -f $(ARTIFACTS)

_init.ok: main.tf
	terraform init
	@touch $@

_server.ok: _init.ok main.tf sshkey
	$(TF_ENVS) terraform apply -auto-approve
	@touch $@

sshkey:
	ssh-keygen -t ed25519 -f $@ -N "" -C ""
