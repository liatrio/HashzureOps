output "app_service_url" {
  description = "URL of the app service"
  value       = azurerm_app_service.web_apps.default_site_hostname
}

output "app_service_rg" {
  description = "Resource Group the app service will be deployed to"
  value       = azurerm_resource_group.app_rg.name
}

output "app_service_location" {
  description = "App Service Location"
  value       = azurerm_resource_group.app_rg.location
}

output "app_service_plan_name" {
  description = "Name of the app service plan"
  value       = azurerm_app_service_plan.app_service_plan.name
}
