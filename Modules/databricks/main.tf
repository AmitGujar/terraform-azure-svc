terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = ">=0.11.0"
    }
  }
}

resource "azurerm_databricks_workspace" "tf_databricks" {
  name                          = "custom-workspace"
  resource_group_name           = var.resource_name
  location                      = var.location
  sku                           = "premium"
  public_network_access_enabled = true
}

locals {
  default_policy = {
    "spark_conf.spark.databricks.cluster.profile" : {
      "type" : "fixed",
      "value" : "singleNode",
      "hidden" : true
    },
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 30
    },
    "node_type_id" : {
      "type" : "fixed",
      "value" : "Standard_F4"
    }
  }
}

resource "databricks_cluster_policy" "tf-managed-policy" {
  name       = "tf_managed_policy"
  definition = jsonencode(local.default_policy)

}

resource "databricks_cluster" "tf_managed_cluster" {
  cluster_name                = "tf-managed"
  spark_version               = "14.3.x-scala2.12"
  policy_id                   = databricks_cluster_policy.tf-managed-policy.id
  apply_policy_default_values = true
  node_type_id                = "Standard_F4"
  autotermination_minutes     = 30
  num_workers                 = 1
  runtime_engine              = "STANDARD"
  enable_elastic_disk         = false

  spark_conf = {
    "fs.azure.account.key.${var.storage_name}.dfs.core.windows.net" = "OAuth",
    "fs.azure.account.oauth.provider.type.${var.storage_name}.dfs.core.windows.net" = "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider"
    "fs.azure.account.oauth2.client.id.${var.storage_name}.dfs.core.windows.net" = var.client_id
    "fs.azure.account.oauth2.client.secret.${var.storage_name}.dfs.core.windows.net" = var.client_secret
    "fs.azure.account.oauth2.client.endpoint.${var.storage_name}.dfs.core.windows.net" = "https://login.microsoftonline.com/${var.tenant_id}/oauth2/token"
  }
}
