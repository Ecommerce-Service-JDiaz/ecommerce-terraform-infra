environment = "dev"
location    = "eastus2"

resource_prefix = "ecommerce"
cluster_name    = "aks-cluster"
dns_prefix      = "ecommerce-dev"

# Configuración del node pool - Dev
node_pool_name    = "system"
node_vm_size      = "Standard_F8s_v2"  # 8 vCPUs, 16 GB RAM - Optimizada para compute
node_disk_size_gb = 128
node_min_count    = 3
node_max_count    = 6

# Auto-scaling
enable_auto_scaling = true

# Monitoring - Dev: Básico (sin Log Analytics)
enable_log_analytics = false

# Backup - Dev: No backup
enable_backup = false

# Tags
tags = {
  Environment = "dev"
  Project     = "ecommerce"
  ManagedBy   = "Terraform"
}

