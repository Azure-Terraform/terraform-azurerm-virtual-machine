# Module Inputs
variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "names" {
  description = "names to be applied to resources"
  type        = map(string)
}

variable "tags" {
  description = "tags to be applied to resources"
  type        = map(string)
}

# Windows
variable "windows_machine_name" {
  description = "Windows Virtual Machine Name - Max 15 characters. If left blank randomly assigned"
  type        = string
  default     = ""
}

# Linux
variable "linux_machine_name" {
  description = "Linux Virtual Machine Name - If left blank generated from metadata module"
  type        = string
  default     = ""
}

# VM Size
variable "virtual_machine_size" {
  description = "Instance size to be provisioned"
  type        = string
}

# VM Type
variable "kernel_type" {
  description = "Virtual machine kernel - windows or linux"
  default     = "linux"
  type        = string
}

# Custom Machine Image
variable "custom_image_id" {
  description = "Custom machine image ID"
  type        = string
  default     = null
}

# Custom User Data
variable "custom_data" {
  description = "The Base64-Encoded Custom Data which should be used for this Virtual Machine"
  type        = string
  default     = null
}

# Operating System
variable "source_image_publisher" {
  description = "Operating System Publisher"
  type        = string
  default     = null
}

variable "source_image_offer" {
  description = "Operating System Name"
  type        = string
  default     = null
}

variable "source_image_sku" {
  description = "Operating System SKU"
  type        = string
  default     = null
}

variable "source_image_version" {
  description = "Operating System Version"
  type        = string
  default     = "latest"
}

# Operating System Disck
variable "operating_system_disk_cache" {
  description = "Type of caching to use on the OS disk - Options: None, ReadOnly or ReadWrite"
  type        = string
  default     = "ReadWrite"

  validation {
    condition     = (contains(["none", "readonly", "readwrite"], lower(var.operating_system_disk_cache)))
    error_message = "OS Disk cache can only be \"None\", \"ReadOnly\" or \"ReadWrite\"."
  }
}

variable "operating_system_disk_type" {
  description = "Type of storage account to use with the OS disk - Options: Standard_LRS, StandardSSD_LRS or Premium_LRS"
  type        = string
  default     = "StandardSSD_LRS"

  validation {
    condition     = (contains(["standard_lrs", "standardssd_lrs", "premium_lrs", "ultrassd_lrs"], lower(var.operating_system_disk_type)))
    error_message = "Public IP sku can only be \"Standard_LRS\", \"StandardSSD_LRS\", \"Premium_LRS\" or \"UltraSSD_LRS\"."
  }
}

variable "operating_system_disk_write_accelerator" {
  description = "Should Write Accelerator be Enabled for this OS Disk?"
  type        = bool
  default     = false
}

# Credentials
variable "admin_username" {
  description = "Default Username - Random if left blank"
  type        = string
  default     = ""
}

variable "admin_password" {
  description = "(Windows) Default Password - Random if left blank"
  type        = string
  default     = ""
  sensitive   = true
}

variable "admin_ssh_public_key" {
  description = "(Linux) Public SSH Key - Generated if left blank"
  type        = string
  default     = ""
  sensitive   = true
}

# Index
variable "machine_count" {
  description = "Unique Identifier/Count - Random if left at 0"
  type        = number
  default     = 0
}

# Networking
variable "subnet_id" {
  description = "Virtual network subnet ID"
  type        = string
}

variable "public_ip_enabled" {
  description = "Create and attach a public interface?"
  type        = bool
  default     = false
}

variable "public_ip_sku" {
  description = "SKU to be used with this public IP - Basic or Standard"
  type        = string
  default     = "Standard"

  validation {
    condition     = (contains(["basic", "standard"], lower(var.public_ip_sku)))
    error_message = "Public IP sku can only be \"Basic\" or \"Standard\"."
  }
}

variable "accelerated_networking" {
  description = "Enable accelerated networking?"
  type        = bool
  default     = false
}

variable "proximity_placement_group" {
  description = "ID of the proximity_placement_group you want the VM to be a member of"
  type        = string
  default     = null
}

variable "ultra_ssd_enabled" {
  description = "Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine."
  type        = bool
  default     = false
}

variable "availability_zone" {
  description = "The Zone in which this Virtual Machine should be created. Changing this forces a new resource to be created."
  type        = number
  default     = null
}

# VM Identity
variable "identity_type" {
  description = "The Managed Service Identity Type of this Virtual Machine. Possible values are SystemAssigned (where Azure will generate a Managed Identity for you), UserAssigned (where you can specify the Managed Identities ID)."
  type        = string
  default     = "SystemAssigned"

  validation {
    condition     = (contains(["systemassigned", "userassigned"], lower(var.identity_type)))
    error_message = "The identity type can only be \"UserAssigned\" or \"SystemAssigned\"."
  }
}

variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned to the VM"
  type        = list(string)
  default     = []
}

variable "diagnostics_storage_account_uri" {
  description = "The Storage Account's Blob Endpoint which should hold the virtual machine's diagnostic files."
  type        = string
  default     = null
}

variable "enable_boot_diagnostics" {
  description = "Whether to enable boot diagnostics on the virtual machine."
  type        = bool
  default     = false
}
