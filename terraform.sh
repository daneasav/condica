#!/bin/bash

terrform-volume-name="terraform-config"
terraform-image-name="hashicorp/terraform"
terraform-image-version="0.11.6"

docker volume create "${terraform-volume-name}"
#docker run -it \
#  -v "${terraform-volume-name}":/.terraform:rw \
#  -v "$(pwd)"/azure.tf:/tmp/azure.tf:ro \
#  "${terraform-image-name}":"${terraform-image-version}" init /tmp
#docker run -it \
#  -v "${terraform-volume-name}":/.terraform:rw \
#  -v "$(pwd)"/azure.tf:/tmp/azure.tf:ro \
#  "${terraform-image-name}":"${terraform-image-version}" plan /tmp
#docker run -it \
#  -v "${terraform-volume-name}":/.terraform:rw \
#  -v "$(pwd)"/azure.tf:/tmp/azure.tf:ro \
#  "${terraform-image-name}":"${terraform-image-version}" apply /tmp
docker volume rm "${terraform-volume-name}"