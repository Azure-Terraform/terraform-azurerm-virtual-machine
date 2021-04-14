terraform {
  required_version = ">= 0.13.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.48.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}
