#!/bin/bash

terraform_volume_name="terraform-config"
terraform_image_name="hashicorp/terraform"
terraform_image_version="0.11.6"

docker volume create "${terraform_volume_name}"
#docker run -it \
#  -v "${terraform_volume_name}":/.terraform:rw \
#  -v "$(pwd)"/azure.tf:/tmp/azure.tf:ro \
#  "${terraform_image_name_":"${_}" init /tmp
#docker run -it \
#  -v "${terraform_volume_name}":/.terraform:rw \
#  -v "$(pwd)"/azure.tf:/tmp/azure.tf:ro \
#  "${terraform_image_name_":"${_}" plan /tmp
#docker run -it \
#  -v "${terraform_volume_name}":/.terraform:rw \
#  -v "$(pwd)"/azure.tf:/tmp/azure.tf:ro \
#  "${terraform_image_name_":"${_}" apply /tmp
docker volume rm "${terraform_volume_name}"