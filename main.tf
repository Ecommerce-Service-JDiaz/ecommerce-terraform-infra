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

# Data source para obtener credenciales del cluster AKS si existe (para cuando create_aks = false pero hay recursos en el estado)
# Solo se usa cuando environment no es "global" (porque global no tiene cluster AKS)
data "azurerm_kubernetes_cluster" "existing" {
  count               = var.create_aks ? 0 : (var.environment != "global" ? 1 : 0)
  name                = "${var.cluster_name}-${var.environment}"
  resource_group_name = "${var.resource_prefix}-rg-${var.environment}"
}

# Provider de Kubernetes - Usa las credenciales del cluster AKS
# Siempre está disponible para manejar recursos existentes en el estado
# Usamos un alias para evitar conflictos
provider "kubernetes" {
  alias = "aks"
  
  # Si create_aks es true, usar credenciales del módulo AKS
  # Si create_aks es false y environment no es "global", intentar usar data source del cluster existente
  # Si no hay cluster disponible, usar config_path (para limpiar recursos del estado si es necesario)
  host = var.create_aks && length(module.aks) > 0 ? module.aks[0].host : (
    var.environment != "global" && length(data.azurerm_kubernetes_cluster.existing) > 0 ? data.azurerm_kubernetes_cluster.existing[0].kube_config[0].host : null
  )
  
  client_certificate = var.create_aks && length(module.aks) > 0 ? base64decode(module.aks[0].client_certificate) : (
    var.environment != "global" && length(data.azurerm_kubernetes_cluster.existing) > 0 ? base64decode(data.azurerm_kubernetes_cluster.existing[0].kube_config[0].client_certificate) : null
  )
  
  client_key = var.create_aks && length(module.aks) > 0 ? base64decode(module.aks[0].client_key) : (
    var.environment != "global" && length(data.azurerm_kubernetes_cluster.existing) > 0 ? base64decode(data.azurerm_kubernetes_cluster.existing[0].kube_config[0].client_key) : null
  )
  
  cluster_ca_certificate = var.create_aks && length(module.aks) > 0 ? base64decode(module.aks[0].cluster_ca_certificate) : (
    var.environment != "global" && length(data.azurerm_kubernetes_cluster.existing) > 0 ? base64decode(data.azurerm_kubernetes_cluster.existing[0].kube_config[0].cluster_ca_certificate) : null
  )
  
  # Si no hay cluster disponible, usar kubeconfig del sistema (para limpiar recursos del estado si es necesario)
  # Esto permite que el provider esté disponible incluso cuando no hay cluster, para manejar recursos existentes en el estado
  config_path = (var.create_aks && length(module.aks) > 0) || (var.environment != "global" && length(data.azurerm_kubernetes_cluster.existing) > 0) ? null : "~/.kube/config"
}

# ConfigMaps para variables de entorno de Spring Boot
module "k8s_configmaps" {
  count  = var.create_aks ? 1 : 0
  source = "./modules/kubernetes/configmaps"

  depends_on = [module.aks]
}

