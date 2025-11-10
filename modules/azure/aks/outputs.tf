output "resource_group_name" {
  description = "Nombre del Resource Group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID del Resource Group"
  value       = azurerm_resource_group.main.id
}

output "cluster_name" {
  description = "Nombre del cluster AKS"
  value       = azurerm_kubernetes_cluster.main.name
}

output "cluster_id" {
  description = "ID del cluster AKS"
  value       = azurerm_kubernetes_cluster.main.id
}

output "cluster_fqdn" {
  description = "FQDN del cluster AKS"
  value       = azurerm_kubernetes_cluster.main.fqdn
}

output "cluster_private_fqdn" {
  description = "FQDN privado del cluster AKS"
  value       = azurerm_kubernetes_cluster.main.private_fqdn
}

output "cluster_kubernetes_version" {
  description = "Versión de Kubernetes del cluster"
  value       = azurerm_kubernetes_cluster.main.kubernetes_version
}

output "kube_config" {
  description = "Configuración de kubectl para el cluster"
  value       = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive   = true
}

output "host" {
  description = "Host del cluster AKS"
  value       = azurerm_kubernetes_cluster.main.kube_config[0].host
  sensitive   = true
}

output "client_key" {
  description = "Client key del cluster AKS"
  value       = azurerm_kubernetes_cluster.main.kube_config[0].client_key
  sensitive   = true
}

output "client_certificate" {
  description = "Client certificate del cluster AKS"
  value       = azurerm_kubernetes_cluster.main.kube_config[0].client_certificate
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Cluster CA certificate"
  value       = azurerm_kubernetes_cluster.main.kube_config[0].cluster_ca_certificate
  sensitive   = true
}

output "vnet_id" {
  description = "ID de la Virtual Network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Nombre de la Virtual Network"
  value       = azurerm_virtual_network.main.name
}

output "subnet_aks_id" {
  description = "ID de la subnet de AKS"
  value       = azurerm_subnet.aks.id
}

output "subnet_nodes_id" {
  description = "ID de la subnet de nodos"
  value       = azurerm_subnet.nodes.id
}

output "log_analytics_workspace_id" {
  description = "ID del Log Analytics Workspace (si está habilitado)"
  value       = var.enable_log_analytics ? azurerm_log_analytics_workspace.main[0].id : null
}

output "log_analytics_workspace_name" {
  description = "Nombre del Log Analytics Workspace (si está habilitado)"
  value       = var.enable_log_analytics ? azurerm_log_analytics_workspace.main[0].name : null
}

output "backup_vault_id" {
  description = "ID del Recovery Services Vault (si está habilitado)"
  value       = var.enable_backup ? azurerm_recovery_services_vault.main[0].id : null
}

output "backup_vault_name" {
  description = "Nombre del Recovery Services Vault (si está habilitado)"
  value       = var.enable_backup ? azurerm_recovery_services_vault.main[0].name : null
}

output "cluster_identity_principal_id" {
  description = "Principal ID de la identidad del cluster AKS"
  value       = azurerm_kubernetes_cluster.main.identity[0].principal_id
}