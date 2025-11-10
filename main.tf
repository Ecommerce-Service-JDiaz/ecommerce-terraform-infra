terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
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

# Módulo AKS - Solo se crea si create_aks es true (no para Key Vault global)
module "aks" {
  count  = var.create_aks ? 1 : 0
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

# Provider de Kubernetes - Usa las credenciales del cluster AKS
# Solo se configura cuando create_aks es true y el módulo AKS existe
# Nota: Cuando create_aks es false, este provider no se usará (no hay recursos de Kubernetes)
# Usamos un alias para evitar conflictos cuando no hay cluster
provider "kubernetes" {
  alias = "aks"
  
  # Solo configurar cuando create_aks es true
  # Cuando create_aks es false, el módulo AKS no existe, por lo que usamos valores null
  # y config_path para que el provider no falle (aunque no se usará)
  host                   = var.create_aks ? (length(module.aks) > 0 ? module.aks[0].host : null) : null
  client_certificate     = var.create_aks ? (length(module.aks) > 0 ? base64decode(module.aks[0].client_certificate) : null) : null
  client_key             = var.create_aks ? (length(module.aks) > 0 ? base64decode(module.aks[0].client_key) : null) : null
  cluster_ca_certificate = var.create_aks ? (length(module.aks) > 0 ? base64decode(module.aks[0].cluster_ca_certificate) : null) : null
  
  # Si no hay cluster, intentar usar kubeconfig del sistema (no se usará porque no hay recursos)
  config_path = var.create_aks ? null : "~/.kube/config"
}

# ConfigMaps para variables de entorno de Spring Boot
module "k8s_configmaps" {
  count  = var.create_aks ? 1 : 0
  source = "./modules/kubernetes/configmaps"

  depends_on = [module.aks]
}

