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
    key                  = "virtualmachine.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

locals {
    size      = "Standard_F2"
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
}

data "azurerm_network_interface" "NIC1" {
  name                = "networkinterface1"
  resource_group_name = "rgVijay20230315"
}

data "azurerm_network_interface" "NIC2" {
  name                = "networkinterface2"
  resource_group_name = "rgVijay20230315"
}

data "terraform_remote_state" "AVSET" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rgVijay20230315"
    storage_account_name = "tfstatevijay"
    container_name       = "terraform"
    key                  = "avset.tfstate"
  }
}

resource "azurerm_windows_virtual_machine" "VM-1" {
  name                = "VM1"
  resource_group_name = var.RGName
  location            = var.location
  size                = local.size
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  availability_set_id = data.terraform_remote_state.AVSET.outputs.avset5id
  network_interface_ids = [
    data.azurerm_network_interface.NIC1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = local.publisher
    offer     = local.offer
    sku       = local.sku
    version   = local.version
  }
}

resource "azurerm_windows_virtual_machine" "VM-2" {
  name                = "VM2"
  resource_group_name = var.RGName
  location            = var.location
  size                = local.size
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  availability_set_id = data.terraform_remote_state.AVSET.outputs.avset5id
  network_interface_ids = [
    data.azurerm_network_interface.NIC2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = local.publisher
    offer     = local.offer
    sku       = local.sku
    version   = local.version
  }
}