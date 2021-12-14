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
  count = (var.kernel_type == "windows" && var.admin_password == "" ? 1 : 0)

  length           = 32
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
  special          = true
  override_special = "!@#$%*()-_=+[]{}:?"
}

resource "tls_private_key" "ssh_key" {
  count = (var.kernel_type == "linux" && var.admin_ssh_public_key == "" ? 1 : 0)

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_integer" "count" {
  min = 01
  max = 99
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
  name                          = local.virtual_machine_name
  location                      = var.names.location
  resource_group_name           = var.resource_group_name
  tags                          = var.tags
  enable_accelerated_networking = var.accelerated_networking

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
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.dynamic.id]
  proximity_placement_group_id    = var.proximity_placement_group

  admin_ssh_key {
    username   = local.admin_username
    public_key = local.admin_ssh_public_key
  }

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

  dynamic "boot_diagnostics" {
    for_each = var.enable_boot_diagnostics ? ["enabled"] : []
    content {
      storage_account_uri = var.diagnostics_storage_account_uri
    }
  }

  os_disk {
    caching                   = var.operating_system_disk_cache
    storage_account_type      = var.operating_system_disk_type
    write_accelerator_enabled = var.operating_system_disk_write_accelerator
  }

  dynamic "additional_capabilities" {
    for_each = var.ultra_ssd_enabled ? ["enabled"] : []
    content {
      ultra_ssd_enabled = var.ultra_ssd_enabled
    }
  }

  zone = var.availability_zone

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }
}

# Windows
resource "azurerm_windows_virtual_machine" "windows" {
  count = (var.kernel_type == "windows" ? 1 : 0)

  name                = local.virtual_machine_name
  location            = var.names.location
  resource_group_name = var.resource_group_name
  tags                = merge(var.tags, { "name" : local.virtual_machine_name })

  size                         = var.virtual_machine_size
  admin_username               = local.admin_username
  admin_password               = local.admin_password
  network_interface_ids        = [azurerm_network_interface.dynamic.id]
  proximity_placement_group_id = var.proximity_placement_group

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

  dynamic "boot_diagnostics" {
    for_each = var.enable_boot_diagnostics ? ["enabled"] : []
    content {
      storage_account_uri = var.diagnostics_storage_account_uri
    }
  }

  os_disk {
    caching                   = var.operating_system_disk_cache
    storage_account_type      = var.operating_system_disk_type
    write_accelerator_enabled = var.operating_system_disk_write_accelerator
  }

  dynamic "additional_capabilities" {
    for_each = var.ultra_ssd_enabled ? ["enabled"] : []
    content {
      ultra_ssd_enabled = var.ultra_ssd_enabled
    }
  }

  zone = var.availability_zone

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }
}
