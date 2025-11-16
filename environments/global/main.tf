terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    # Configuración del backend se pasa via -backend-config en el workflow
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "keyvault" {
  source = "../../modules/azure/keyvault"

  resource_prefix              = var.resource_prefix
  location                     = var.location
  tenant_id                    = var.tenant_id
  service_principal_object_id  = var.service_principal_object_id
  aks_cluster_identities       = var.aks_cluster_identities

  azure_resource_group_dev   = var.azure_resource_group_dev
  aks_cluster_name_dev       = var.aks_cluster_name_dev
  azure_resource_group_stage = var.azure_resource_group_stage
  aks_cluster_name_stage     = var.aks_cluster_name_stage
  azure_resource_group_prod  = var.azure_resource_group_prod
  aks_cluster_name_prod      = var.aks_cluster_name_prod

  dockerhub_username = var.dockerhub_username
  dockerhub_token    = var.dockerhub_token
  azure_credential   = var.azure_credential
  azure_credential_object_id = var.azure_credential_object_id

  spring_cloud_config_server_git_uri         = var.spring_cloud_config_server_git_uri
  spring_cloud_config_server_git_default_label = var.spring_cloud_config_server_git_default_label

  tags = var.tags
}

