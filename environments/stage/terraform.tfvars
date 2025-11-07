environment = "stage"
location    = "eastus2"

resource_prefix = "ecommerce"
cluster_name    = "aks-cluster"
dns_prefix      = "ecommerce-stage"

# Configuración del node pool - Stage
node_pool_name    = "system"
node_vm_size      = "Standard_B2s"
node_disk_size_gb = 64
node_min_count    = 2
node_max_count    = 4

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

