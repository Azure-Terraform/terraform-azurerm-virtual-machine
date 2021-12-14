# Variables
locals {

  count = (var.machine_count != 0 ? var.machine_count : random_integer.count.result)

  default_linux_name   = "vm-${var.names.resource_group_type}-${var.names.product_name}-${var.names.environment}-${var.names.location}-${local.count}"
  linux_machine_name   = (var.linux_machine_name != "" ? var.linux_machine_name : local.default_linux_name)
  windows_machine_name = (var.windows_machine_name != "" ? var.windows_machine_name : random_string.windows_name.result)

  admin_username       = (var.admin_username != "" ? var.admin_username : random_string.username.result)
  admin_password       = (var.admin_password != "" ? var.admin_password : try(random_password.password[0].result, ""))
  admin_ssh_public_key = (var.admin_ssh_public_key != "" ? var.admin_ssh_public_key : try(tls_private_key.ssh_key[0].public_key_openssh, ""))

  virtual_machine_name = (var.kernel_type == "linux" ? local.linux_machine_name : local.windows_machine_name)
  virtual_machine_id   = (var.kernel_type == "linux" ? azurerm_linux_virtual_machine.linux.0.id : azurerm_windows_virtual_machine.windows.0.id)

  principal_id = (var.kernel_type == "linux" ? azurerm_linux_virtual_machine.linux[0].identity.0.principal_id : azurerm_windows_virtual_machine.windows[0].identity.0.principal_id)

  # Validation
  validate_user_assigned_identity = ((lower(var.identity_type) == "userassigned" && var.identity_ids == []) ?
  file("ERROR: identity_ids must be provided when using User Assigned identity") : true)

  validate_utra_ssd = ((var.ultra_ssd_enabled == true && var.availability_zone == null) ?
  file("ERROR: variable for availability_zone is required when ultra_ssd_enabled is true.") : true)
}
