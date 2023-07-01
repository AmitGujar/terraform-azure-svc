# terraform {
#   backend "azurerm" {
#     storage_account_name = "__storageaccount__"
#     container_name       = "terraform"
#     key                  = "terraform.tfstate"
#     access_key           = "__storagekey__"
#   }
# }

module "resource_group" {
  source        = "./Modules/resourceGroup"
  resource_name = var.resource_name
  location      = var.location
}

module "virtual_network" {
  source        = "./Modules/virtualNetwork"
  resource_name = var.resource_name
  location      = var.location
  depends_on = [
    module.resource_group
  ]
}

module "virtual_machine" {
  source        = "./Modules/virtualMachine"
  resource_name = var.resource_name
  location      = var.location
  subnet_id     = data.azurerm_subnet.data_jumpbox_subnet.id
  public_ip_id  = data.azurerm_public_ip.data_jumpbox_public_ip.id
  depends_on = [
    module.virtual_network
  ]
}