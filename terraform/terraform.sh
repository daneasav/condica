#!/bin/bash

terraform_volume_name="terraform"
terraform_config_volume_name="terraform-config"
terraform_image_name="hashicorp/terraform"
terraform_image_version="0.11.6"

cd "$(dirname "$0")" || exit

# create volumes
docker volume create "${terraform_volume_name}"
docker volume create "${terraform_config_volume_name}"

# add config file into the config volume
docker run -v "${terraform_config_volume_name}":/tmp --name helper busybox true
docker cp . helper:/tmp
docker rm helper

# terraform init, plan, apply
docker run --rm \
  -v "${terraform_volume_name}":/.terraform:rw \
  -v "${terraform_config_volume_name}":/tmp:rw \
  "${terraform_image_name}":"${terraform_image_version}" init /tmp

# recreate infrastructure
docker run --rm \
  -v "${terraform_volume_name}":/.terraform:rw \
  -v "${terraform_config_volume_name}":/tmp:rw \
  "${terraform_image_name}":"${terraform_image_version}" plan /tmp
docker run --rm \
  -v "${terraform_volume_name}":/.terraform:rw \
  -v "${terraform_config_volume_name}":/tmp:rw \
  "${terraform_image_name}":"${terraform_image_version}" destroy -auto-approve /tmp
docker run --rm \
  -v "${terraform_volume_name}":/.terraform:rw \
  -v "${terraform_config_volume_name}":/tmp:rw \
  "${terraform_image_name}":"${terraform_image_version}" apply -auto-approve /tmp

# remove the volumes
docker volume rm "${terraform_volume_name}"
docker volume rm "${terraform_config_volume_name}"
