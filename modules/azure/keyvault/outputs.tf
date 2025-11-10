output "key_vault_id" {
  description = "ID del Key Vault"
  value       = azurerm_key_vault.global.id
}

output "key_vault_name" {
  description = "Nombre del Key Vault"
  value       = azurerm_key_vault.global.name
}

output "key_vault_uri" {
  description = "URI del Key Vault"
  value       = azurerm_key_vault.global.vault_uri
}

output "resource_group_name" {
  description = "Nombre del Resource Group global"
  value       = azurerm_resource_group.global.name
}

output "resource_group_id" {
  description = "ID del Resource Group global"
  value       = azurerm_resource_group.global.id
}

