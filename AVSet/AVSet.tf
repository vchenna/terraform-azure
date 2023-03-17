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
    key                  = "avset.tfstate"
  } 
}

provider "azurerm" {
  # Configuration options
  features {}
}

locals {
    location      = "EastUS"
    RGName        = "rgVijay20230315"
    updateDomain  = 5
    faultDomain   = 2
}

output "avset5id" {
    description = "This is for capturing AVSET5 Id"
    value = azurerm_availability_set.AVSET5.id
}

resource "azurerm_availability_set" "AVSET1" {
  name                = "AvailabilitySet1"
  location            = local.location
  resource_group_name = local.RGName

  platform_update_domain_count = local.updateDomain
  platform_fault_domain_count  = local.faultDomain 
}

resource "azurerm_availability_set" "AVSET2" {
  name                = "AvailabilitySet2"
  location            = local.location
  resource_group_name = local.RGName

  platform_update_domain_count = local.updateDomain
  platform_fault_domain_count  = local.faultDomain 
}

resource "azurerm_availability_set" "AVSET3" {
  name                = "AvailabilitySet3"
  location            = local.location
  resource_group_name = local.RGName

  platform_update_domain_count = local.updateDomain
  platform_fault_domain_count  = local.faultDomain 
}

resource "azurerm_availability_set" "AVSET4" {
  name                = "AvailabilitySet4"
  location            = "West Europe"
  resource_group_name = local.RGName

  platform_update_domain_count = local.updateDomain
  platform_fault_domain_count  = local.faultDomain 
}

resource "azurerm_availability_set" "AVSET5" {
  name                = "AvailabilitySet5"
  location            = "West Europe"
  resource_group_name = local.RGName

  platform_update_domain_count = local.updateDomain
  platform_fault_domain_count  = local.faultDomain 
}