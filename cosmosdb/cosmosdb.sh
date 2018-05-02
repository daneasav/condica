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
cosmosdb_name=${2:-condik-db}
function_name=${3:-condik-record-entry}
cosmosdb_account="condik-cosmosdb-account"
cosmosdb_collection="UserInput"

azcli_volume_name="azcli"

cd "$(dirname "$0")" || exit

# create volumes
docker volume create "${azcli_volume_name}"

# create functions deployment
azcli_run login --service-principal -u "${azure_client_id}" -p "${azure_client_secret}" --tenant "${azure_tenant_id}"
azcli_run account set --subscription "${azure_subscription_id}"

# create cosmos db account, database and colletion
azcli_run cosmosdb create \
  --name "${cosmosdb_account}" \
  --resource-group "${resource_group}" 
#  --locations "northeurope"
azcli_run cosmosdb database create \
  --db-name "${cosmosdb_name}" \
  --name "${cosmosdb_account}" \
  --resource-group "${resource_group}"
azcli_run cosmosdb collection create \
    --db-name "${cosmosdb_name}" \
    --collection-name "${cosmosdb_collection}" \
    --name "${cosmosdb_account}" \
    --resource-group "${resource_group}" \
    --throughput 400

#create the function connection string
cosmosdb_account_endpoint=$(azcli_run cosmosdb show \
  --name "${cosmosdb_account}" \
  --resource-group "${resource_group}" \
  --query "documentEndpoint" \
  --output tsv | tail -1)
cosmosdb_account_key=$(azcli_run cosmosdb list-keys \
  --name "${cosmosdb_account}" \
  --resource-group "${resource_group}" \
  --query "primaryMasterKey" \
  --output tsv | tail -1)
azcli_run functionapp config appsettings set \
  --name "${function_name}" \
  --resource-group "${resource_group}" \
  --settings "cosmosdb-${function_name}-ConnectionString=AccountEndpoint=${cosmosdb_account_endpoint};AccountKey=${cosmosdb_account_key}"

azcli_run logout

# remove the volumes
docker volume rm "${azcli_volume_name}"
