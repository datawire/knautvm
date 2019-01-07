SHELL = /bin/bash

.PHONY: terraform.tfvars.tpl init plan apply validate machine ssh

DKR_MOUNTDIR = /project
DKR_WORKDIR = $(DKR_MOUNTDIR)
DKR_RUN = docker run $(DOCKER_ARGS)

override DOCKER_ARGS += --rm \
	-it \
	-u $(shell id -u):$(shell id -g) \
	-e GOOGLE_CREDENTIALS=/tmp/datawireio.json \
	--volume=/tmp/datawireio.json:/tmp/datawireio.json:ro \
	--volume=$(CURDIR)/../..:$(DKR_MOUNTDIR) \
	--workdir=$(DKR_WORKDIR)/tools/gcloud

TF_IMAGE = hashicorp/terraform:light
TF_INIT = $(DKR_RUN) $(TF_IMAGE) init -get -upgrade

TF_PLAN = $(DKR_RUN) $(TF_IMAGE) plan $(TF_PLANARGS)

TF_APPLY = $(DKR_RUN) $(TF_IMAGE) apply tfplan
TF_VALIDATE = $(DKR_RUN) $(TF_IMAGE) validate
TF_OUTPUT = $(DKR_RUN) $(TF_IMAGE) output

terraform.tfvars.tpl: MACHINE_NAME_SUFFIX=$(USER)
terraform.tfvars.tpl:
	sed -e "s/__MACHINE_NAME_SUFFIX__/$(MACHINE_NAME_SUFFIX)/g" < terraform.tfvars.tpl > terraform.tfvars

terraform-shell: DOCKER_ARGS += --entrypoint=/bin/sh
terraform-shell: terraform.tfvars.tpl
	cp /keybase/private/plombardi/gcloud/datawireio.json /tmp/datawireio.json
	$(DKR_RUN) $(TF_IMAGE)

init: terraform.tfvars.tpl
	cp /keybase/private/plombardi/gcloud/datawireio.json /tmp/datawireio.json
	$(TF_INIT)

plan: init
	$(TF_PLAN) -out tfplan

apply: validate plan
	$(TF_APPLY)

validate: init
	$(TF_VALIDATE)

output:
	$(TF_OUTPUT) machine_public_ip

machine-down: TF_PLANARGS += -destroy
machine-down: init
	$(TF_PLAN) -out tfplan.destroy
	$(DKR_RUN) $(TF_IMAGE) apply tfplan.destroy

machine-up: apply

ssh:
	ssh -i ../../etc/insecure_id_rsa "dev@$(shell $(TF_OUTPUT) machine_public_ip)"
