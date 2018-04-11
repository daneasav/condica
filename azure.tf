# azure login details
variable "azure-credentials" {
  type = "map"
  default = {
    subscription_id = "f3d364a5-0d95-48de-a207-54dd4fb781cd"
    client_id       = "ecd8572e-cd33-4640-8be6-e8665d6cbe1e"
    client_secret   = "cbd65a5b-6ed9-44d8-9a48-06796d1dafbf"
    tenant_id       = "88d0a5a9-d61a-4dd6-9a75-6637f3fe6bd8"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.azure-credentials["subscription_id"]}"
  client_id       = "${var.azure-credentials["client_id"]}"
  client_secret   = "${var.azure-credentials["client_secret"]}"
  tenant_id       = "${var.azure-credentials["tenant_id"]}"
}
