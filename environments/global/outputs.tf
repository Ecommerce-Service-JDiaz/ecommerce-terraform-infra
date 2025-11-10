output "key_vault_id" {
  description = "ID del Key Vault"
  value       = module.keyvault.key_vault_id
}

output "key_vault_name" {
  description = "Nombre del Key Vault"
  value       = module.keyvault.key_vault_name
}

output "key_vault_uri" {
  description = "URI del Key Vault"
  value       = module.keyvault.key_vault_uri
}

output "resource_group_name" {
  description = "Nombre del Resource Group global"
  value       = module.keyvault.resource_group_name
}

