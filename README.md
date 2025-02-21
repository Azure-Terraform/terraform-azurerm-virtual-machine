# Azure - Virtual Machine Module

## Introduction
Generic module for creating a virtual machine (Windows or Linux) in Azure. 
Using a unique count (machine_count) to prevent duplicates
<br />

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.70.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.70.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.linux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.dynamic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_public_ip.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_windows_virtual_machine.windows](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_integer.count](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.username](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.windows_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [tls_private_key.ssh_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accelerated_networking"></a> [accelerated\_networking](#input\_accelerated\_networking) | Enable accelerated networking? | `bool` | `false` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | (Windows) Default Password - Random if left blank | `string` | `""` | no |
| <a name="input_admin_ssh_public_key"></a> [admin\_ssh\_public\_key](#input\_admin\_ssh\_public\_key) | (Linux) Public SSH Key - Generated if left blank | `string` | `""` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Default Username - Random if left blank | `string` | `""` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The Zone in which this Virtual Machine should be created. Changing this forces a new resource to be created. | `number` | `null` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | The Base64-Encoded Custom Data which should be used for this Virtual Machine | `string` | `null` | no |
| <a name="input_custom_image_id"></a> [custom\_image\_id](#input\_custom\_image\_id) | Custom machine image ID | `string` | `null` | no |
| <a name="input_diagnostics_storage_account_uri"></a> [diagnostics\_storage\_account\_uri](#input\_diagnostics\_storage\_account\_uri) | The Storage Account's Blob Endpoint which should hold the virtual machine's diagnostic files. | `string` | `null` | no |
| <a name="input_enable_boot_diagnostics"></a> [enable\_boot\_diagnostics](#input\_enable\_boot\_diagnostics) | Whether to enable boot diagnostics on the virtual machine. | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of user managed identity ids to be assigned to the VM | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The Managed Service Identity Type of this Virtual Machine. Possible values are SystemAssigned (where Azure will generate a Managed Identity for you), UserAssigned (where you can specify the Managed Identities ID). | `string` | `"SystemAssigned"` | no |
| <a name="input_kernel_type"></a> [kernel\_type](#input\_kernel\_type) | Virtual machine kernel - windows or linux | `string` | `"linux"` | no |
| <a name="input_license"></a> [license](#input\_license) | Add license to Image for systems that use ubuntu pro support | `string` | `""` | no |
| <a name="input_linux_machine_name"></a> [linux\_machine\_name](#input\_linux\_machine\_name) | Linux Virtual Machine Name - If left blank generated from metadata module | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region | `string` | n/a | yes |
| <a name="input_machine_count"></a> [machine\_count](#input\_machine\_count) | Unique Identifier/Count - Random if left at 0 | `number` | `0` | no |
| <a name="input_names"></a> [names](#input\_names) | names to be applied to resources | `map(string)` | n/a | yes |
| <a name="input_operating_system_disk_cache"></a> [operating\_system\_disk\_cache](#input\_operating\_system\_disk\_cache) | Type of caching to use on the OS disk - Options: None, ReadOnly or ReadWrite | `string` | `"ReadWrite"` | no |
| <a name="input_operating_system_disk_type"></a> [operating\_system\_disk\_type](#input\_operating\_system\_disk\_type) | Type of storage account to use with the OS disk - Options: Standard\_LRS, StandardSSD\_LRS or Premium\_LRS | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_operating_system_disk_write_accelerator"></a> [operating\_system\_disk\_write\_accelerator](#input\_operating\_system\_disk\_write\_accelerator) | Should Write Accelerator be Enabled for this OS Disk? | `bool` | `false` | no |
| <a name="input_proximity_placement_group"></a> [proximity\_placement\_group](#input\_proximity\_placement\_group) | ID of the proximity\_placement\_group you want the VM to be a member of | `string` | `null` | no |
| <a name="input_public_ip_enabled"></a> [public\_ip\_enabled](#input\_public\_ip\_enabled) | Create and attach a public interface? | `bool` | `false` | no |
| <a name="input_public_ip_sku"></a> [public\_ip\_sku](#input\_public\_ip\_sku) | SKU to be used with this public IP - Basic or Standard | `string` | `"Standard"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_source_image_offer"></a> [source\_image\_offer](#input\_source\_image\_offer) | Operating System Name | `string` | `null` | no |
| <a name="input_source_image_publisher"></a> [source\_image\_publisher](#input\_source\_image\_publisher) | Operating System Publisher | `string` | `null` | no |
| <a name="input_source_image_sku"></a> [source\_image\_sku](#input\_source\_image\_sku) | Operating System SKU | `string` | `null` | no |
| <a name="input_source_image_version"></a> [source\_image\_version](#input\_source\_image\_version) | Operating System Version | `string` | `"latest"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Virtual network subnet ID | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to be applied to resources | `map(string)` | n/a | yes |
| <a name="input_ultra_ssd_enabled"></a> [ultra\_ssd\_enabled](#input\_ultra\_ssd\_enabled) | Should the capacity to enable Data Disks of the UltraSSD\_LRS storage account type be supported on this Virtual Machine. | `bool` | `false` | no |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | Instance size to be provisioned | `string` | n/a | yes |
| <a name="input_windows_machine_name"></a> [windows\_machine\_name](#input\_windows\_machine\_name) | Windows Virtual Machine Name - Max 15 characters. If left blank randomly assigned | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | n/a |
| <a name="output_admin_ssh_key"></a> [admin\_ssh\_key](#output\_admin\_ssh\_key) | n/a |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | Credentials |
| <a name="output_azurerm_network_interface_id"></a> [azurerm\_network\_interface\_id](#output\_azurerm\_network\_interface\_id) | Interface id |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | Identity |
| <a name="output_virtual_machine_id"></a> [virtual\_machine\_id](#output\_virtual\_machine\_id) | Virtal Machine Details |
| <a name="output_virtual_machine_name"></a> [virtual\_machine\_name](#output\_virtual\_machine\_name) | n/a |
| <a name="output_virtual_machine_private_ip"></a> [virtual\_machine\_private\_ip](#output\_virtual\_machine\_private\_ip) | n/a |

<!--- END_TF_DOCS --->
