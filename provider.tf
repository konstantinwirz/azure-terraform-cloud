terraform {

  required_version = "= 1.5.1"

  cloud {
    organization = "kwic"
    workspaces {
      name = "azure-github-actions"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.62.0"
    }
  }
}


provider "azurerm" {
  features {}
}
