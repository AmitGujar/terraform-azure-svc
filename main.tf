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

module "app_service" {
  source                = "./Modules/appServices"
  webapp_name           = var.webapp_name
  resource_name         = var.resource_name
  location              = var.location
  app_service_plan_name = var.app_service_plan_name
  depends_on = [
    module.resource_group
  ]
}

module "storage_account" {
  source        = "./Modules/storage"
  resource_name = var.resource_name
  location      = var.location
  depends_on = [
    module.resource_group
  ]

}

module "container_instance" {
  source               = "./Modules/conInstance"
  resource_name        = var.resource_name
  location             = var.location
  share_name           = module.storage_account.share_name
  storage_account_name = module.storage_account.storage_account_name
  storage_account_key  = module.storage_account.storage_account_key
  depends_on = [
    module.storage_account
  ]
}
