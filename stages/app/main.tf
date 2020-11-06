terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  version = ">= 2.35.0"
  features {}
}

locals {
}

resource "azurerm_resource_group" "app_rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "hashzureops-appservice"
  location            = var.location
  resource_group_name = azurerm_resource_group.app_rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = var.app_service_plan_tier
    size = var.app_service_plan_size
  }
}

############ Web App Configuration #################
resource "azurerm_app_service" "web_apps" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = azurerm_resource_group.app_rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    linux_fx_version = "DOCKER|${var.docker_registry_url}/${var.app_image}:${var.image_version}"
    always_on        = "true"
    scm_type = "None"
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    DOCKER_REGISTRY_SERVER_URL          = var.docker_registry_url
    PORT                                = "9898"
    DOCKER_REGISTRY_SERVER_USERNAME     = var.acr_user
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.acr_password
  }

}

