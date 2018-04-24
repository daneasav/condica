#!/bin/bash

function azcli_run() {
  azcli_image_name="microsoft/azure-cli"
  azcli_image_version="latest"

  echo "Run azure cli with the following flags: " "$@" 

  docker run --rm \
    -v "${azcli_volume_name}":/root/.azure \
    "${azcli_image_name}":"${azcli_image_version}" az "$@"
}

resource_group=${1:-condik}
git_branch=${2:-master}

azcli_volume_name="azcli"

cd "$(dirname "$0")" || exit

# create volumes
docker volume create "${azcli_volume_name}"

# create functions deployment
azcli_run login --service-principal -u "${azure_client_id}" -p "${azure_client_secret}" --tenant "${azure_tenant_id}"
azcli_run account set --subscription "${azure_subscription_id}"
azcli_run functionapp deployment source config \
  --name "git_config_${git_branch}" \
  --repo-url "${git_url}" \
  --resource-group "${resource_group}" \
  --branch "${git_branch}" \
  --git-token "${git_token}"
azcli_run logout

# remove the volumes
docker volume rm "${azcli_volume_name}"
