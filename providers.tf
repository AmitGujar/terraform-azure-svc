terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.45.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "databricks" {
  host                        = module.databricks.workspace_url
  azure_workspace_resource_id = module.databricks.workspace_id
}
