# Resource Group global para Key Vault
resource "azurerm_resource_group" "keyvault" {
  name     = "${var.resource_prefix}-rg-global"
  location = var.location

  tags = merge(
    var.tags,
    {
      Environment = "global"
      ManagedBy   = "Terraform"
      Purpose     = "Global Resources"
    }
  )
}

# Data source para obtener el tenant_id actual
data "azurerm_client_config" "current" {}

# Key Vault global para todos los ambientes
# Nota: Los secretos se insertan desde GitHub Actions usando Azure CLI
module "keyvault" {
  source = "./modules/azure/keyvault"

  key_vault_name             = "${replace(var.resource_prefix, "-", "")}kv${substr(md5("${var.resource_prefix}global"), 0, 8)}"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.keyvault.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  service_principal_object_id = data.azurerm_client_config.current.object_id
  purge_protection_enabled   = false # Cambiar a true en producción
  network_default_action     = "Allow" # Permitir acceso desde Azure Services

  tags = merge(
    var.tags,
    {
      Environment = "global"
      ManagedBy   = "Terraform"
    }
  )
}

