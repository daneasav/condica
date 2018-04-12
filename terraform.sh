#!/bin/bash

terraform_volume_name="terraform-config"
terraform_image_name="hashicorp/terraform"
terraform_image_version="0.11.6"

docker volume create "${terraform_volume_name}"
docker run \
  -v "${terraform_volume_name}":/.terraform:rw \
  -v "$(pwd)"/azure.tf:/tmp/azure.tf:ro \
  "${terraform_image_name}":"${terraform_image_version}" init /tmp
docker run \
  -v "${terraform_volume_name}":/.terraform:rw \
  -v "$(pwd)"/azure.tf:/tmp/azure.tf:ro \
  "${terraform_image_name}":"${terraform_image_version}" plan /tmp
docker run \
  -v "${terraform_volume_name}":/.terraform:rw \
  -v "$(pwd)"/azure.tf:/tmp/azure.tf:ro \
  "${terraform_image_name}":"${terraform_image_version}" apply /tmp
docker volume rm "${terraform_volume_name}"