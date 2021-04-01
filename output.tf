# Virtal Machine Details
output "virtual_machine_id" {
  value = local.virtual_machine_id
}

output "virtual_machine_name" {
  value = local.virtual_machine_name
}

output "virtual_machine_private_ip" {
  value = azurerm_network_interface.dynamic.private_ip_address
}

# Credentials
output "admin_username" {
  value = local.admin_username
}

output "admin_password" {
  value     = local.admin_password
  sensitive = true
}