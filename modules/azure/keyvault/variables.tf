variable "key_vault_name" {
  description = "Nombre del Key Vault (debe ser único globalmente)"
  type        = string
}

variable "location" {
  description = "Región de Azure donde se creará el Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group donde se creará el Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "ID del tenant de Azure"
  type        = string
}

variable "service_principal_object_id" {
  description = "Object ID del Service Principal que ejecuta Terraform"
  type        = string
}

variable "purge_protection_enabled" {
  description = "Habilitar purge protection (previene eliminación permanente)"
  type        = bool
  default     = false
}

variable "network_default_action" {
  description = "Acción por defecto para network ACLs (Allow o Deny)"
  type        = string
  default     = "Allow"
}

variable "tags" {
  description = "Tags para aplicar a los recursos"
  type        = map(string)
  default     = {}
}

