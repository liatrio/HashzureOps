resource "azurerm_key_vault" "tfstate_keyvault" {
  name                        = "kvtfstate"
  location                    = azurerm_resource_group.tfstate_storage.location
  resource_group_name         = azurerm_resource_group.tfstate_storage.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  soft_delete_enabled      = true
  purge_protection_enabled = true

  tags = merge(local.tags, {})
}

resource "azurerm_key_vault_access_policy" "storage" {
  key_vault_id = azurerm_key_vault.tfstate_keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_storage_account.tfstate_storage_account.identity.0.principal_id

  key_permissions = [
    "get",
    "create",
    "list",
    "restore",
    "recover",
    "unwrapkey",
    "wrapkey",
    "purge",
    "encrypt",
    "decrypt",
    "sign",
    "verify"
  ]

  secret_permissions = ["get"]
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.tfstate_keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "get",
    "create",
    "delete",
    "list",
    "restore",
    "recover",
    "unwrapkey",
    "wrapkey",
    "purge",
    "encrypt",
    "decrypt",
    "sign",
    "verify"
  ]
  secret_permissions = ["get"]
}


resource "azurerm_key_vault_key" "tfstate_kv_key" {
  name         = "tfex-key"
  key_vault_id = azurerm_key_vault.tfstate_keyvault.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    azurerm_key_vault_access_policy.client,
    azurerm_key_vault_access_policy.storage,
  ]

  tags = merge(local.tags, {})
}
