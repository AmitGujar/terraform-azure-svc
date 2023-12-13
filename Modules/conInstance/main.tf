resource "azurerm_container_group" "elastic_container" {
  name                = "elastic-container"
  location            = var.location
  resource_group_name = var.resource_name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = "Always"
  dns_name_label      = "elastic-container"

  container {
    name   = var.elastic_container_name
    image  = var.elastic_image_name
    cpu    = var.elastic_cpu_cores
    memory = var.elastic_ram_in_gb

    ports {
      port     = var.elastic_port
      protocol = "TCP"
    }

    environment_variables = {
      "ES_JAVA_OPTS" = "-Xms9g -Xmx9g"
    }

    volume {
      name                 = "volume"
      mount_path           = "/usr/share/elasticsearch/data"
      share_name           = var.share_name
      storage_account_name = var.storage_account_name
      storage_account_key  = var.storage_account_key
    }
  }
}

resource "azurerm_container_group" "neo_container" {
  name                = "neo4j-container"
  location            = var.location
  resource_group_name = var.resource_name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = "Always"
  dns_name_label      = "neo-containers"

  container {
    name   = var.neo_container_name
    image  = var.neo_image_name
    cpu    = var.neo_cpu_cores
    memory = var.neo_ram_in_gb
    ports {
      port     = 7474
      protocol = "TCP"
    }

    ports {
      port     = 7687
      protocol = "TCP"
    }

    volume {
      name                 = "volume"
      mount_path           = "/data"
      share_name           = var.share_name
      storage_account_name = var.storage_account_name
      storage_account_key  = var.storage_account_key
    }
  }
}
