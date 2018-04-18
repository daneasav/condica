# azure login details
variable "azure-credentials" {
  type = "map"
  default = {
    subscription_id = "1ea27b67-8bb9-4189-9a99-c7fff25c2f67"
    client_id       = "964c4a41-fc2f-47b6-be26-688dd6a80574"
    client_secret   = "W/Hn0ztWK3v1uQmf5vhGOFCctI3mHzMeEdS1ii0133I="
    #client_secret   = "a494bf36-3e4e-11e8-b467-0ed5f89f718b"
    tenant_id       = "88d0a5a9-d61a-4dd6-9a75-6637f3fe6bd8"
  }
}

# github details
variable "github" {
  type = "map"
  default = {
    repo_url = "https://github.com/despickme/condica.git"
    branch   = "master"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.azure-credentials["subscription_id"]}"
  client_id       = "${var.azure-credentials["client_id"]}"
  client_secret   = "${var.azure-credentials["client_secret"]}"
  tenant_id       = "${var.azure-credentials["tenant_id"]}"
}

# create a resource group 
resource "azurerm_resource_group" "condik" {
    name = "condik"
    location = "northeurope"
}

resource "azurerm_storage_account" "condik-storage" {
  name                     = "condikstorage"
  resource_group_name      = "${azurerm_resource_group.condik.name}"
  location                 = "${azurerm_resource_group.condik.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "service-plan" {
  name                = "condik-service-plan"
  location            = "${azurerm_resource_group.condik.location}"
  resource_group_name = "${azurerm_resource_group.condik.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_function_app" "condik-function" {
  name                      = "condik-record-entry"
  location                  = "${azurerm_resource_group.condik.location}"
  resource_group_name       = "${azurerm_resource_group.condik.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.service-plan.id}"
  storage_connection_string = "${azurerm_storage_account.condik-storage.primary_connection_string}"

  app_settings {
    deployment-source-url     = "${var.github["repo_url"]}"
    deployment-source-branch  = "${var.github["branch"]}"
  }
}
