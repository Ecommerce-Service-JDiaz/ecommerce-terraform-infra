environment = "dev"
location    = "eastus2"

resource_prefix = "ecommerce"
cluster_name    = "aks-cluster"
dns_prefix      = "ecommerce-dev"

# Configuración del node pool - Dev
node_pool_name    = "system"
node_vm_size      = "Standard_B2s"
node_disk_size_gb = 64
node_min_count    = 1
node_max_count    = 1

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

