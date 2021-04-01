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
}

variable "operating_system_disk_type" {
  description = "Type of storage account to use with the OS disk - Options: Standard_LRS, StandardSSD_LRS or Premium_LRS"
  type        = string
  default     = "StandardSSD_LRS"
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
  description = "Default Password - Random if left blank"
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
}