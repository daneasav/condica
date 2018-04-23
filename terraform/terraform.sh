#!/bin/bash

function terraform_run() {
  terraform_image_name="hashicorp/terraform"
  terraform_image_version="0.11.6"

  echo "Run terrform with the following flags: " "$@" 

  docker run --rm \
    -v "${terraform_volume_name}":/.terraform:rw \
    -v "${terraform_config_volume_name}":/tmp:rw \
    "${terraform_image_name}":"${terraform_image_version}" "$@"
}

terraform_volume_name="terraform"
terraform_config_volume_name="terraform-config"
  
cd "$(dirname "$0")" || exit

# create volumes
docker volume create "${terraform_volume_name}"
docker volume create "${terraform_config_volume_name}"

# add config file into the config volume
docker run -v "${terraform_config_volume_name}":/tmp --name helper busybox true
docker cp . helper:/tmp
docker rm helper

terraform_vars="-var azure_subscription_id=${azure_subscription_id}\
 -var azure_client_id=${azure_client_id}\
 -var azure_client_secret=${azure_client_secret}\
 -var azure_tenant_id=${azure_tenant_id}"

# terraform init
terraform_run init /tmp

# delete current infrastructure
terraform_run plan -out=/tmp/condik.tfplan ${terraform_vars} /tmp 
terraform_run import -config=/tmp -state-out=/tmp/condik.tfstate ${terraform_vars} azurerm_resource_group.condik /subscriptions/${azure_subscription_id}/resourceGroups/condik
terraform_run destroy -state=/tmp/condik.tfstate -auto-approve ${terraform_vars} /tmp

# recreate infrastructure
terraform_run plan -out=/tmp/condik.tfplan ${terraform_vars} /tmp
terraform_run apply -auto-approve ${terraform_vars} /tmp

# remove the volumes
docker volume rm "${terraform_volume_name}"
docker volume rm "${terraform_config_volume_name}"
