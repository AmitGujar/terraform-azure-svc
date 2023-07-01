output "resource_group" {
  value = module.resource_group.resource_name
}

output "virtual_network" {
  value = module.virtual_network.intellidoc_network
}

output "tls_private_key" {
  value     = module.virtual_machine.tls_private_key
  sensitive = true
}

output "public_ip_address" {
  value = module.virtual_machine.public_ip_address
}