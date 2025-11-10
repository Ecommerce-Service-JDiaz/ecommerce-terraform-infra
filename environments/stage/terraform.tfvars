environment = "stage"
location    = "eastus2"

resource_prefix = "ecommerce"
cluster_name    = "aks-cluster"
dns_prefix      = "ecommerce-stage"

# Configuración del node pool - Stage
node_pool_name    = "system"
node_vm_size      = "Standard_F16s_v2"  # 16 vCPUs, 32 GB RAM - Alta performance
node_disk_size_gb = 256
node_min_count    = 3
node_max_count    = 6

# Auto-scaling
enable_auto_scaling = true

# Monitoring - Stage: Básico (sin Log Analytics)
enable_log_analytics = false

# Backup - Stage: Semanal
enable_backup        = true
backup_frequency     = "Weekly"
backup_retention_days = 30

# Tags
tags = {
  Environment = "stage"
  Project     = "ecommerce"
  ManagedBy   = "Terraform"
  SLA         = "95%"
}

