resource "azurerm_key_vault" "tf_managed_keyvault" {
  name                = "kvtfmanagedisgreat${var.random_integer}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = [
      "Get",
      "List"
    ]

    secret_permissions = [
      "Get",
      "List"
    ]

    storage_permissions = [
      "Get",
      "List"
    ]
  }
}
