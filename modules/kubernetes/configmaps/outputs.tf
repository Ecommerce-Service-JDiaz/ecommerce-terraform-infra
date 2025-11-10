output "configmap_name" {
  description = "Nombre del ConfigMap creado"
  value       = kubernetes_config_map.spring_env.metadata[0].name
}

output "configmap_namespace" {
  description = "Namespace del ConfigMap"
  value       = kubernetes_config_map.spring_env.metadata[0].namespace
}

