# Resource Group Global para Key Vault
resource "azurerm_resource_group" "global" {
  name     = "${var.resource_prefix}-rg-global"
  location = var.location

  tags = merge(
    var.tags,
    {
      Environment = "global"
      ManagedBy   = "Terraform"
      Purpose     = "KeyVault"
    }
  )
}

# Azure Key Vault Global
resource "azurerm_key_vault" "global" {
  name                = "${replace(var.resource_prefix, "-", "")}kv${substr(md5("${var.resource_prefix}global"), 0, 4)}"
  location            = azurerm_resource_group.global.location
  resource_group_name = azurerm_resource_group.global.name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  # Habilitar soft delete y purge protection
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  # Network ACLs - Permitir acceso desde Azure Services
  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = merge(
    var.tags,
    {
      Environment = "global"
      ManagedBy   = "Terraform"
      Purpose     = "KeyVault"
    }
  )
}

# Access Policy para el Service Principal (para que GitHub Actions pueda escribir)
# Permisos completos en Key Vault para gestión total
resource "azurerm_key_vault_access_policy" "service_principal" {
  key_vault_id = azurerm_key_vault.global.id
  tenant_id    = var.tenant_id
  object_id    = var.service_principal_object_id

  # Permisos completos para Keys
  key_permissions = [
    "Get",
    "List",
    "Create",
    "Update",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Import",
    "Decrypt",
    "Encrypt",
    "UnwrapKey",
    "WrapKey",
    "Verify",
    "Sign",
    "Purge"
  ]

  # Permisos completos para Secrets
  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Purge"
  ]

  # Permisos completos para Certificates
  certificate_permissions = [
    "Get",
    "List",
    "Create",
    "Update",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Import",
    "ManageContacts",
    "ManageIssuers",
    "GetIssuers",
    "ListIssuers",
    "SetIssuers",
    "DeleteIssuers",
    "Purge"
  ]

  # Permisos para Storage (si se usa)
  storage_permissions = [
    "Get",
    "List",
    "Delete",
    "Set",
    "Update",
    "RegenerateKey",
    "Recover",
    "Purge",
    "Backup",
    "Restore",
    "SetSAS",
    "ListSAS",
    "GetSAS",
    "DeleteSAS"
  ]
}

# Access Policy para el Service Principal de AZURE_CREDENTIAL (permisos completos como admin supremo)
resource "azurerm_key_vault_access_policy" "azure_credential" {
  count = var.azure_credential_object_id != "" ? 1 : 0

  key_vault_id = azurerm_key_vault.global.id
  tenant_id    = var.tenant_id
  object_id    = var.azure_credential_object_id

  # Permisos completos para Keys
  key_permissions = [
    "Get",
    "List",
    "Create",
    "Update",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Import",
    "Decrypt",
    "Encrypt",
    "UnwrapKey",
    "WrapKey",
    "Verify",
    "Sign",
    "Purge"
  ]

  # Permisos completos para Secrets
  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Purge"
  ]

  # Permisos completos para Certificates
  certificate_permissions = [
    "Get",
    "List",
    "Create",
    "Update",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Import",
    "ManageContacts",
    "ManageIssuers",
    "GetIssuers",
    "ListIssuers",
    "SetIssuers",
    "DeleteIssuers",
    "Purge"
  ]

  # Permisos completos para Storage
  storage_permissions = [
    "Get",
    "List",
    "Delete",
    "Set",
    "Update",
    "RegenerateKey",
    "Recover",
    "Purge",
    "Backup",
    "Restore",
    "SetSAS",
    "ListSAS",
    "GetSAS",
    "DeleteSAS"
  ]
}

# Access Policy para el System-Assigned Identity del cluster AKS (para que pueda leer)
# Nota: Esto se actualizará después de crear los clusters
resource "azurerm_key_vault_access_policy" "aks_identity" {
  for_each = var.aks_cluster_identities

  key_vault_id = azurerm_key_vault.global.id
  tenant_id    = var.tenant_id
  object_id    = each.value

  secret_permissions = [
    "Get",
    "List"
  ]
}

# Secrets del Key Vault - Resource Groups y Cluster Names
resource "azurerm_key_vault_secret" "resource_group_dev" {
  name         = "AZURE-RESOURCE-GROUP-DEV"
  value        = var.azure_resource_group_dev
  key_vault_id = azurerm_key_vault.global.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}

resource "azurerm_key_vault_secret" "aks_cluster_name_dev" {
  name         = "AKS-CLUSTER-NAME-DEV"
  value        = var.aks_cluster_name_dev
  key_vault_id = azurerm_key_vault.global.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}

resource "azurerm_key_vault_secret" "resource_group_stage" {
  name         = "AZURE-RESOURCE-GROUP-STAGE"
  value        = var.azure_resource_group_stage
  key_vault_id = azurerm_key_vault.global.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}

resource "azurerm_key_vault_secret" "aks_cluster_name_stage" {
  name         = "AKS-CLUSTER-NAME-STAGE"
  value        = var.aks_cluster_name_stage
  key_vault_id = azurerm_key_vault.global.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}

resource "azurerm_key_vault_secret" "resource_group_prod" {
  name         = "AZURE-RESOURCE-GROUP-PROD"
  value        = var.azure_resource_group_prod
  key_vault_id = azurerm_key_vault.global.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}

resource "azurerm_key_vault_secret" "aks_cluster_name_prod" {
  name         = "AKS-CLUSTER-NAME-PROD"
  value        = var.aks_cluster_name_prod
  key_vault_id = azurerm_key_vault.global.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}

# Secrets de Docker Hub
resource "azurerm_key_vault_secret" "dockerhub_username" {
  name         = "DOCKERHUB-USERNAME"
  value        = var.dockerhub_username
  key_vault_id = azurerm_key_vault.global.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}

resource "azurerm_key_vault_secret" "dockerhub_token" {
  name         = "DOCKERHUB-TOKEN"
  value        = var.dockerhub_token
  key_vault_id = azurerm_key_vault.global.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}

# Secret de Azure Credential (opcional)
resource "azurerm_key_vault_secret" "azure_credential" {
  count        = var.azure_credential != "" ? 1 : 0
  name         = "AZURE-CREDENTIAL"
  value        = var.azure_credential
  key_vault_id = azurerm_key_vault.global.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}

# Secrets de Spring Cloud Config Server
resource "azurerm_key_vault_secret" "spring_cloud_config_server_git_uri" {
  name         = "SPRING-CLOUD-CONFIG-SERVER-GIT-URI"
  value        = var.spring_cloud_config_server_git_uri
  key_vault_id = azurerm_key_vault.global.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}

resource "azurerm_key_vault_secret" "spring_cloud_config_server_git_default_label" {
  name         = "SPRING-CLOUD-CONFIG-SERVER-GIT-DEFAULT-LABEL"
  value        = var.spring_cloud_config_server_git_default_label
  key_vault_id = azurerm_key_vault.global.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}

resource "azurerm_key_vault_secret" "eureka_client_serviceurl_defaultzone" {
  name         = "EUREKA-CLIENT-SERVICEURL-DEFAULTZONE"
  value        = var.eureka_client_serviceurl_defaultzone
  key_vault_id = azurerm_key_vault.global.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}

