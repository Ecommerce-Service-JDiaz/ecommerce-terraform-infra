output "cluster_name" {
  description = "Nombre del cluster AKS"
  value       = try(module.aks[0].cluster_name, null)
}

output "cluster_fqdn" {
  description = "FQDN del cluster AKS"
  value       = try(module.aks[0].cluster_fqdn, null)
}

output "cluster_kubernetes_version" {
  description = "Versión de Kubernetes del cluster"
  value       = try(module.aks[0].cluster_kubernetes_version, null)
}

output "resource_group_name" {
  description = "Nombre del Resource Group"
  value       = try(module.aks[0].resource_group_name, null)
}

output "vnet_name" {
  description = "Nombre de la Virtual Network"
  value       = try(module.aks[0].vnet_name, null)
}

output "log_analytics_workspace_name" {
  description = "Nombre del Log Analytics Workspace (si está habilitado)"
  value       = try(module.aks[0].log_analytics_workspace_name, null)
}

output "backup_vault_name" {
  description = "Nombre del Recovery Services Vault (si está habilitado)"
  value       = try(module.aks[0].backup_vault_name, null)
}

output "kube_config_command" {
  description = "Comando para obtener la configuración de kubectl"
  value       = try("az aks get-credentials --resource-group ${module.aks[0].resource_group_name} --name ${module.aks[0].cluster_name}", null)
}

output "key_vault_name" {
  description = "Nombre del Key Vault global"
  value       = try(module.keyvault.key_vault_name, null)
}

output "key_vault_uri" {
  description = "URI del Key Vault global"
  value       = try(module.keyvault.key_vault_uri, null)
}

output "k8s_configmap_name" {
  description = "Nombre del ConfigMap de Spring Boot creado en Kubernetes"
  value       = try(module.k8s_configmaps[0].configmap_name, null)
}

output "k8s_configmap_namespace" {
  description = "Namespace del ConfigMap de Spring Boot"
  value       = try(module.k8s_configmaps[0].configmap_namespace, null)
}

