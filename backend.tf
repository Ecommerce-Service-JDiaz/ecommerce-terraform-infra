# Backend configuration para almacenar el estado de Terraform en Azure Storage
# Esto permite que múltiples personas/CI trabajen con el mismo estado

terraform {
  backend "azurerm" {
    # Estos valores pueden venir de variables de entorno o ser especificados en terraform init
    # resource_group_name  = "tfstate-rg"           # Opcional: desde env var ARM_RESOURCE_GROUP_NAME
    # storage_account_name = "tfstatestorage"       # Opcional: desde env var ARM_STORAGE_ACCOUNT_NAME
    # container_name       = "tfstate"              # Opcional: desde env var ARM_CONTAINER_NAME
    # key                  = "terraform.tfstate"    # Opcional: desde env var ARM_STATE_KEY
    # subscription_id      = "..."                   # Opcional: desde env var ARM_SUBSCRIPTION_ID
    # tenant_id           = "..."                   # Opcional: desde env var ARM_TENANT_ID
    
    # Nota: Si no se especifican aquí, Terraform buscará estas variables de entorno:
    # - ARM_RESOURCE_GROUP_NAME
    # - ARM_STORAGE_ACCOUNT_NAME
    # - ARM_CONTAINER_NAME
    # - ARM_STATE_KEY (opcional, default: terraform.tfstate)
    # - ARM_SUBSCRIPTION_ID
    # - ARM_TENANT_ID
    # - ARM_CLIENT_ID (para Service Principal)
    # - ARM_CLIENT_SECRET (para Service Principal)
  }
}

