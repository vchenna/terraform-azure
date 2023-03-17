terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.47.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rgVijay20230315"
    storage_account_name = "tfstatevijay"
    container_name       = "terraform"
    key                  = "nic.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

data "terraform_remote_state" "subnetID" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rgVijay20230315"
    storage_account_name = "tfstatevijay"
    container_name       = "terraform"
    key                  = "backend.tfstate"
  }
}

resource "azurerm_network_interface" "NIC1" {
  name                = "networkinterface1"
  location            = "West Europe"
  resource_group_name = "rgVijay20230315"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.terraform_remote_state.subnetID.outputs.devsubnetid
    private_ip_address_allocation = "Dynamic"
  }
}

