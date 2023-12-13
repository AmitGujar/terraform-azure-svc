output "elastic_container_ip" {
  value = azurerm_container_group.elastic_container.ip_address
}

output "elastic_dns_name_label" {
  value = azurerm_container_group.elastic_container.fqdn
}

output "neo_container_ip" {
  value = azurerm_container_group.neo_container.ip_address
}

output "neo_container_dns_name_label" {
  value = azurerm_container_group.neo_container.fqdn
}
