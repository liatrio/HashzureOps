# https://www.terraform.io/docs/providers/azurerm/r/storage_account.html
resource "azurerm_storage_account" "tfstate_storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.tfstate_storage.name
  location                 = azurerm_resource_group.tfstate_storage.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "RAGZRS"

  identity {
    type = "SystemAssigned"
  }

  tags = merge(local.tags, {})
}

resource "azurerm_storage_container" "tfstate_container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate_storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_account_customer_managed_key" "tfstate_sa_customer_managed_key" {
  storage_account_id = azurerm_storage_account.tfstate_storage_account.id
  key_vault_id       = azurerm_key_vault.tfstate_keyvault.id
  key_name           = azurerm_key_vault_key.tfstate_kv_key.name
  key_version        = azurerm_key_vault_key.tfstate_kv_key.version
}
