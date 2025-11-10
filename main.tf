terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  # Las credenciales se obtienen de variables de entorno:
  # - ARM_CLIENT_ID (Service Principal Client ID)
  # - ARM_CLIENT_SECRET (Service Principal Client Secret)
  # - ARM_SUBSCRIPTION_ID (Azure Subscription ID)
  # - ARM_TENANT_ID (Azure Tenant ID)
  # 
  # O usando Azure CLI: az login (para desarrollo local)
  
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "aks" {
  source = "./modules/azure/aks"

  # Información básica
  environment     = var.environment
  location        = var.location
  resource_prefix = var.resource_prefix

  # Configuración del cluster
  cluster_name              = var.cluster_name
  kubernetes_version        = var.kubernetes_version
  dns_prefix                = var.dns_prefix
  private_cluster_enabled   = var.private_cluster_enabled

  # Configuración del node pool
  node_pool_name      = var.node_pool_name
  node_vm_size        = var.node_vm_size
  node_disk_size_gb   = var.node_disk_size_gb
  node_min_count      = var.node_min_count
  node_max_count      = var.node_max_count
  enable_auto_scaling = var.enable_auto_scaling

  # Monitoring
  enable_log_analytics = var.enable_log_analytics
  log_analytics_sku    = var.log_analytics_sku

  # Backup
  enable_backup        = var.enable_backup
  backup_frequency    = var.backup_frequency
  backup_retention_days = var.backup_retention_days

  # Tags
  tags = var.tags
}

