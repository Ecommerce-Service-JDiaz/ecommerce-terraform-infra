# Azure Key Vault - Global para todos los ambientes
resource "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  # Habilitar soft delete y purge protection para seguridad
  soft_delete_retention_days = 7
  purge_protection_enabled   = var.purge_protection_enabled

  # Network ACLs - Permitir acceso desde Azure Services y desde IPs específicas
  network_acls {
    default_action = var.network_default_action
    bypass         = "AzureServices"
  }

  # Acceso del Service Principal que ejecuta Terraform
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.service_principal_object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore"
    ]

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Delete",
      "Recover",
      "Backup",
      "Restore"
    ]
  }

  tags = merge(
    var.tags,
    {
      Environment = "global"
      ManagedBy   = "Terraform"
      Purpose     = "Global Secrets"
    }
  )
}

