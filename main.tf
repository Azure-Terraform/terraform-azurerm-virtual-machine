# Randoms
resource "random_string" "windows_name" {
  length  = 15
  special = false
}

resource "random_string" "username" {
  length  = 20
  special = false
}

resource "random_password" "password" {
  length      = 32
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

resource "random_integer" "count" {
  min = 01
  max = 99
}

# Variables
locals {
  count = (var.machine_count != 0 ? var.machine_count : random_integer.count.result)

  default_linux_name   = "vm-${var.names.resource_group_type}-${var.names.product_name}-${var.names.environment}-${var.names.location}-${local.count}"
  linux_machine_name   = (var.linux_machine_name != "" ? var.linux_machine_name : local.default_linux_name)
  windows_machine_name = (var.windows_machine_name != "" ? var.windows_machine_name : random_string.windows_name.result)

  admin_username = (var.admin_username != "" ? var.admin_username : random_string.username.result)
  admin_password = (var.admin_password != "" ? var.admin_password : random_password.password.result)

  virtual_machine_name = (var.kernel_type == "linux" ? local.linux_machine_name : local.windows_machine_name)
  virtual_machine_id   = (var.kernel_type == "linux" ? azurerm_linux_virtual_machine.linux.0.id : azurerm_windows_virtual_machine.windows.0.id)
}


# Network Interfaces
resource "azurerm_public_ip" "primary" {
  count = (var.public_ip_enabled == true ? 1 : 0)

  name                = local.virtual_machine_name
  location            = var.names.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  allocation_method = "Static"
  sku               = var.public_ip_sku
}

resource "azurerm_network_interface" "dynamic" {
  name                = local.virtual_machine_name
  location            = var.names.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_enabled ? azurerm_public_ip.primary[0].id : ""
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "linux" {
  count = (var.kernel_type == "linux" ? 1 : 0)

  name                = local.virtual_machine_name
  location            = var.names.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  size                            = var.virtual_machine_size
  admin_username                  = local.admin_username
  admin_password                  = local.admin_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.dynamic.id]

  source_image_id = var.custom_image_id
  custom_data     = var.custom_data

  dynamic "source_image_reference" {
    for_each = var.custom_image_id == null ? ["no_custom_image_provided"] : []

    content {
      publisher = var.source_image_publisher
      offer     = var.source_image_offer
      sku       = var.source_image_sku
      version   = var.source_image_version
    }
  }

  os_disk {
    caching                   = var.operating_system_disk_cache
    storage_account_type      = var.operating_system_disk_type
    write_accelerator_enabled = var.operating_system_disk_write_accelerator
  }
}


# Windows
resource "azurerm_windows_virtual_machine" "windows" {
  count = (var.kernel_type == "windows" ? 1 : 0)

  name                = local.virtual_machine_name
  location            = var.names.location
  resource_group_name = var.resource_group_name
  tags                = merge(var.tags, { "name" : local.virtual_machine_name })


  size           = var.virtual_machine_size
  admin_username = local.admin_username
  admin_password = local.admin_password

  network_interface_ids = [azurerm_network_interface.dynamic.id]

  source_image_id = var.custom_image_id
  custom_data     = var.custom_data

  dynamic "source_image_reference" {
    for_each = var.custom_image_id == null ? ["no_custom_image_provided"] : []

    content {
      publisher = var.source_image_publisher
      offer     = var.source_image_offer
      sku       = var.source_image_sku
      version   = var.source_image_version
    }
  }

  os_disk {
    caching                   = var.operating_system_disk_cache
    storage_account_type      = var.operating_system_disk_type
    write_accelerator_enabled = var.operating_system_disk_write_accelerator
  }

}