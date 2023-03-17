terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.47.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

resource "azurerm_resource_group" "resourceGroup" {
  name     = "rgVijay20230315"
  location = "West Europe"
}

resource "azurerm_virtual_network" "virtualNetwork" {
  name                = "vnet1"
  location            = azurerm_resource_group.resourceGroup.location
  resource_group_name = azurerm_resource_group.resourceGroup.name
  address_space       = ["10.0.0.0/16"]
}
