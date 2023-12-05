resource "random_integer" "random" {
  min = 10
  max = 99
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "${var.webapp_name}-${random_integer.random.result}"
  location            = var.location
  resource_group_name = var.resource_name
  service_plan_id     = azurerm_service_plan.app_service_plan.id
  https_only          = true
  site_config {
    minimum_tls_version = "1.2"
    
  }
}
