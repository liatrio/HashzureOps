locals {
  tags = merge(var.default_tags, {
    environment          = "terraform-bootstrap"
    terraform_module_url = var.reference_repo_url
  })
}

provider "azurerm" {
  version = "~> 2.12"
  features {}
}


data "azurerm_client_config" "current" {
}


resource "azurerm_resource_group" "tfstate_storage" {
  name     = var.resource_group
  location = var.location
  tags     = merge(local.tags, {})
}

