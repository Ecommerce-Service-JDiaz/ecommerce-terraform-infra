environment = "prod"
location    = "eastus2"

resource_prefix = "ecommerce"
cluster_name    = "aks-cluster"
dns_prefix      = "ecommerce-prod"

# Configuración del node pool - Prod
# Nota: Cuota limitada a 6 vCPUs. Usando Standard_D2s_v3 (2 vCPUs) para permitir escalado hasta 3 nodos
node_pool_name    = "system"
node_vm_size      = "Standard_D2s_v3"  # 2 vCPUs, 8 GB RAM - Duplica la memoria manteniendo 3 nodos
node_disk_size_gb = 256
node_min_count    = 1
node_max_count    = 3  # Máximo 3 nodos × 2 vCPUs = 6 vCPUs (límite de cuota)

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

