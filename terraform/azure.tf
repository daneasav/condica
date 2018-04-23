# azure login details
variable "azure_subscription_id" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_tenant_id" {}

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
  subscription_id = "${var.azure_subscription_id}"
  client_id       = "${var.azure_client_id}"
  client_secret   = "${var.azure_client_secret}"
  tenant_id       = "${var.azure_tenant_id}"
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
