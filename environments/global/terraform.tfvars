environment = "global"
location    = "eastus2"

resource_prefix = "ecommerce"

# No crear AKS, solo Key Vault
create_aks = false

# Variables requeridas por el módulo AKS (no se usarán porque create_aks = false)
cluster_name    = "dummy"
dns_prefix      = "dummy"
node_vm_size    = "Standard_F2s_v2"
node_disk_size_gb = 128
node_min_count  = 1
node_max_count  = 1

# Tags globales
tags = {
  Environment = "global"
  Project     = "ecommerce"
  ManagedBy   = "Terraform"
  Purpose     = "Global Resources"
}

