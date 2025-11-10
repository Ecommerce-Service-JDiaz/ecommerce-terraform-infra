resource_prefix = "ecommerce"
location        = "eastus2"

# Estos valores se pasan desde GitHub Secrets en el workflow
# tenant_id y service_principal_object_id se obtienen de los secrets
# Los demás valores vienen de los secrets de GitHub

tags = {
  Environment = "global"
  Project     = "ecommerce"
  ManagedBy   = "Terraform"
  Purpose     = "KeyVault"
}

