output "acr_name" {
  value       = azurerm_container_registry.acr.name
  description = "Name of Azure Container Registry"
}

output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "Name of Azure Container Registry Login Server"
}

output "rg_name" {
  value       = azurerm_resource_group.rg.name
  description = "Name of Resource Group"
}

output "rg_location" {
  value       = azurerm_resource_group.rg.location
  description = "Location where resources were deployed"
}
