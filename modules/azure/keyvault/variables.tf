variable "resource_prefix" {
  description = "Prefijo para los nombres de los recursos"
  type        = string
}

variable "location" {
  description = "Región de Azure donde se desplegarán los recursos"
  type        = string
}

variable "tenant_id" {
  description = "ID del tenant de Azure"
  type        = string
}

variable "service_principal_object_id" {
  description = "Object ID del Service Principal usado para autenticación"
  type        = string
}

variable "aks_cluster_identities" {
  description = "Mapa de identidades de los clusters AKS (environment -> object_id)"
  type        = map(string)
  default     = {}
}

variable "azure_resource_group_dev" {
  description = "Nombre del Resource Group de Dev"
  type        = string
}

variable "aks_cluster_name_dev" {
  description = "Nombre del cluster AKS de Dev"
  type        = string
}

variable "azure_resource_group_stage" {
  description = "Nombre del Resource Group de Stage"
  type        = string
}

variable "aks_cluster_name_stage" {
  description = "Nombre del cluster AKS de Stage"
  type        = string
}

variable "azure_resource_group_prod" {
  description = "Nombre del Resource Group de Prod"
  type        = string
}

variable "aks_cluster_name_prod" {
  description = "Nombre del cluster AKS de Prod"
  type        = string
}

variable "kubernetes_namespace_dev" {
  description = "Nombre del namespace de Kubernetes para Dev"
  type        = string
}

variable "kubernetes_namespace_stage" {
  description = "Nombre del namespace de Kubernetes para Stage"
  type        = string
}

variable "kubernetes_namespace_prod" {
  description = "Nombre del namespace de Kubernetes para Prod"
  type        = string
}

variable "dockerhub_username" {
  description = "Usuario de Docker Hub"
  type        = string
}

variable "dockerhub_token" {
  description = "Token de Docker Hub"
  type        = string
  sensitive   = true
}

variable "azure_credential" {
  description = "Credencial de Azure (opcional)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "azure_credential_object_id" {
  description = "Object ID del Service Principal de AZURE_CREDENTIAL (opcional)"
  type        = string
  default     = ""
}

variable "spring_cloud_config_server_git_uri" {
  description = "URI del repositorio Git para Spring Cloud Config Server"
  type        = string
}

variable "spring_cloud_config_server_git_default_label" {
  description = "Label por defecto (rama) del repositorio Git para Spring Cloud Config Server"
  type        = string
}

variable "eureka_client_serviceurl_defaultzone" {
  description = "URL del servicio Eureka Client Default Zone"
  type        = string
}

variable "tags" {
  description = "Tags a aplicar a los recursos"
  type        = map(string)
  default     = {}
}

