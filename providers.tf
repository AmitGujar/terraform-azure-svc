terraform {
  backend "azurerm" {
    storage_account_name = "__STORAGE_ACCOUNT_NAME__"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
    access_key           = "__ACCESS_KEY__"
  }


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

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

provider "databricks" {
  host                        = module.databricks.workspace_url
  azure_workspace_resource_id = module.databricks.workspace_id
  client_id                   = var.client_id
  client_secret               = var.client_secret
}
