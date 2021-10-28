# Azure - Virtual Machine Module

## Introduction
Generic module for creating a virtual machine (Windows or Linux) in Azure. 
Using a unique count (machine_count) to prevent duplicates
<br />

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.15 |
| azurerm | >= 2.70.0 |
| random | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.70.0 |
| random | >= 3.1.0 |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| accelerated\_networking | Enable accelerated networking? | `bool` | `false` | no |
| admin\_password | (Windows) Default Password - Random if left blank | `string` | `""` | no |
| admin\_ssh\_public\_key | (Linux) Public SSH Key - Generated if left blank | `string` | `""` | no |
| admin\_username | Default Username - Random if left blank | `string` | `""` | no |
| custom\_data | The Base64-Encoded Custom Data which should be used for this Virtual Machine | `string` | `null` | no |
| custom\_image\_id | Custom machine image ID | `string` | `null` | no |
| identity\_ids | Specifies a list of user managed identity ids to be assigned to the VM | `list(string)` | `[]` | no |
| identity\_type | The Managed Service Identity Type of this Virtual Machine. Possible values are SystemAssigned (where Azure will generate a Managed Identity for you), UserAssigned (where you can specify the Managed Identities ID). | `string` | `"SystemAssigned"` | no |
| kernel\_type | Virtual machine kernel - windows or linux | `string` | `"linux"` | no |
| linux\_machine\_name | Linux Virtual Machine Name - If left blank generated from metadata module | `string` | `""` | no |
| location | Azure region | `string` | n/a | yes |
| machine\_count | Unique Identifier/Count - Random if left at 0 | `number` | `0` | no |
| names | names to be applied to resources | `map(string)` | n/a | yes |
| operating\_system\_disk\_cache | Type of caching to use on the OS disk - Options: None, ReadOnly or ReadWrite | `string` | `"ReadWrite"` | no |
| operating\_system\_disk\_type | Type of storage account to use with the OS disk - Options: Standard\_LRS, StandardSSD\_LRS or Premium\_LRS | `string` | `"StandardSSD_LRS"` | no |
| operating\_system\_disk\_write\_accelerator | Should Write Accelerator be Enabled for this OS Disk? | `bool` | `false` | no |
| proximity\_placement\_group | ID of the proximity\_placement\_group you want the VM to be a member of | `string` | `null` | no |
| public\_ip\_enabled | Create and attach a public interface? | `bool` | `false` | no |
| public\_ip\_sku | SKU to be used with this public IP - Basic or Standard | `string` | `"Standard"` | no |
| resource\_group\_name | Resource group name | `string` | n/a | yes |
| source\_image\_offer | Operating System Name | `string` | `null` | no |
| source\_image\_publisher | Operating System Publisher | `string` | `null` | no |
| source\_image\_sku | Operating System SKU | `string` | `null` | no |
| source\_image\_version | Operating System Version | `string` | `"latest"` | no |
| subnet\_id | Virtual network subnet ID | `string` | n/a | yes |
| tags | tags to be applied to resources | `map(string)` | n/a | yes |
| virtual\_machine\_size | Instance size to be provisioned | `string` | n/a | yes |
| windows\_machine\_name | Windows Virtual Machine Name - Max 15 characters. If left blank randomly assigned | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| admin\_password | n/a |
| admin\_ssh\_key | n/a |
| admin\_username | Credentials |
| azurerm\_network\_interface\_id | Interface id |
| identity\_principal\_id | Identity |
| virtual\_machine\_id | Virtal Machine Details |
| virtual\_machine\_name | n/a |
| virtual\_machine\_private\_ip | n/a |

<!--- END_TF_DOCS --->
