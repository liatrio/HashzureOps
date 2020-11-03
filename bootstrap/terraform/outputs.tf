output "account_id" {
  value = data.azurerm_client_config.current.client_id
}

output "current_client_config" {
  value = data.azurerm_client_config.current
}

output "default_common_tags" {

  value = local.tags
}

output "boostrap_resource_group_name" {
  value = azurerm_resource_group.tfstate_storage.name
}

output "keyvault_name" {
  value = azurerm_key_vault.tfstate_keyvault.name
}

output "storage_account_name" {
  value = azurerm_storage_account.tfstate_storage_account.name
}
