environment = "prod"
location    = "eastus2"

resource_prefix = "ecommerce"
cluster_name    = "aks-cluster"
dns_prefix      = "ecommerce-prod"

# Configuración del node pool - Prod
node_pool_name    = "system"
node_vm_size      = "Standard_F16s_v2"  # 16 vCPUs, 32 GB RAM - Máxima performance
node_disk_size_gb = 256
node_min_count    = 3
node_max_count    = 6

# Auto-scaling
enable_auto_scaling = true

# Monitoring - Prod: Mejorado (con Log Analytics)
enable_log_analytics = true
log_analytics_sku    = "PerGB2018"

# Backup - Prod: Diario
enable_backup        = true
backup_frequency     = "Daily"
backup_retention_days = 30

# Tags
tags = {
  Environment = "prod"
  Project     = "ecommerce"
  ManagedBy   = "Terraform"
  SLA         = "99.9%"
  Criticality = "High"
}

