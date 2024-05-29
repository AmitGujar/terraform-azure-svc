resource "azurerm_container_app_environment" "dev" {
  name                = "dev-environment"
  location            = var.location
  resource_group_name = var.resource_name
}

resource "azurerm_container_app" "myapplication" {
  name                         = "niceapplication"
  container_app_environment_id = azurerm_container_app_environment.dev.id
  resource_group_name          = var.resource_name
  revision_mode                = "Single"

  template {
    container {
      name   = "nicecontainerapp"
      image  = "amitgujar/neo4j:latest"
      cpu    = 2.0
      memory = "4.0Gi"
    }
    max_replicas = "2"
    min_replicas = "1"
  }

  ingress {
    allow_insecure_connections = true
    target_port                = "7474"
    external_enabled           = true
    traffic_weight {
      percentage      = "100"
      latest_revision = true
    }
    transport = "auto"
  }
}
