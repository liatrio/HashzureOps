terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  version = ">= 2.14.0"
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}


resource "azurerm_container_registry" "acr" {
  name                = var.acr_instance_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Premium"
  admin_enabled       = false
}

