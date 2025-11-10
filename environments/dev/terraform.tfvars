environment = "dev"
location    = "eastus2"

resource_prefix = "ecommerce"
cluster_name    = "aks-cluster"
dns_prefix      = "ecommerce-dev"

# Configuración del node pool - Dev
# Nota: Cuota limitada a 6 vCPUs. Usando Standard_F2s_v2 (2 vCPUs) para permitir escalado hasta 3 nodos
node_pool_name    = "system"
node_vm_size      = "Standard_F2s_v2"  # 2 vCPUs, 4 GB RAM - Optimizada para compute (ajustada a cuota)
node_disk_size_gb = 128
node_min_count    = 1
node_max_count    = 3  # Máximo 3 nodos × 2 vCPUs = 6 vCPUs (límite de cuota)

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

