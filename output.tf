output "resource_group" {
  value = module.resource_group.resource_name
}

output "virtual_network" {
  value = module.virtual_network.virtual_network
}

output "tls_private_key" {
  value     = module.virtual_machine.tls_private_key
  sensitive = true
}

output "public_ip_address" {
  value = module.virtual_machine.public_ip_address
}

output "app_service_plan_name" {
  value = module.app_service.app_service_plan_name
}

output "webapp_name" {
  value = module.app_service.webapp_name
}

output "webapp_url" {
  value = module.app_service.webapp_url
}

output "elastic_container_ip" {
  value = module.container_instance.elastic_container_ip
}

output "neo_container_ip" {
  value = module.container_instance.neo_container_ip 
}

output "storage_account_name" {
  value = module.storage_account.storage_account_name
}

output "storage_account_key" {
  value     = module.storage_account.storage_account_key
  sensitive = true
}

output "storage_share_name" {
  value = module.storage_account.share_name
}

output "elastic_dns_name_label" {
  value = module.container_instance.elastic_dns_name_label
}

output "neo_container_dns_name_label" {
  value = module.container_instance.neo_container_dns_name_label
}
