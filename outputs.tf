output "cluster_name" {
  description = "Nombre del cluster AKS"
  value       = module.aks.cluster_name
}

output "cluster_fqdn" {
  description = "FQDN del cluster AKS"
  value       = module.aks.cluster_fqdn
}

output "cluster_kubernetes_version" {
  description = "Versión de Kubernetes del cluster"
  value       = module.aks.cluster_kubernetes_version
}

output "resource_group_name" {
  description = "Nombre del Resource Group"
  value       = module.aks.resource_group_name
}

output "vnet_name" {
  description = "Nombre de la Virtual Network"
  value       = module.aks.vnet_name
}

output "log_analytics_workspace_name" {
  description = "Nombre del Log Analytics Workspace (si está habilitado)"
  value       = module.aks.log_analytics_workspace_name
}

output "backup_vault_name" {
  description = "Nombre del Recovery Services Vault (si está habilitado)"
  value       = module.aks.backup_vault_name
}

output "kube_config_command" {
  description = "Comando para obtener la configuración de kubectl"
  value       = "az aks get-credentials --resource-group ${module.aks.resource_group_name} --name ${module.aks.cluster_name}"
}

