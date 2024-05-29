resource "random_integer" "rand" {
  min = 10
  max = 99
}

resource "azurerm_storage_account" "tfstorage" {
  resource_group_name      = var.resource_name
  location                 = var.location
  name                     = "tfstorageisgreat${random_integer.rand.result}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true

  tags = {
    "container" = "volume"
  }
}

resource "azurerm_storage_share" "tfshare" {
  name                 = var.share_name
  storage_account_name = azurerm_storage_account.tfstorage.name
  quota                = 50
}

resource "azurerm_storage_container" "raw" {
  name = "raw"
  storage_account_name = azurerm_storage_account.tfstorage.name
}

resource "azurerm_storage_container" "processed" {
  name = "processed"
  storage_account_name = azurerm_storage_account.tfstorage.name
}

resource "azurerm_storage_container" "presentation" {
  name = "presentation"
  storage_account_name = azurerm_storage_account.tfstorage.name
}

resource "azurerm_storage_container" "test" {
  name = "test"
  storage_account_name = azurerm_storage_account.tfstorage.name
}

resource "azurerm_role_assignment" "blob_contributer" {
  scope = azurerm_storage_account.tfstorage.id
  principal_id = var.principal_id
}