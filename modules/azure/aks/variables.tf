variable "environment" {
  description = "Entorno de despliegue (dev, stage, prod)"
  type        = string
}

variable "location" {
  description = "Región de Azure donde se desplegarán los recursos"
  type        = string
}

variable "resource_prefix" {
  description = "Prefijo para los nombres de los recursos"
  type        = string
}

variable "cluster_name" {
  description = "Nombre del cluster AKS"
  type        = string
}

variable "kubernetes_version" {
  description = "Versión de Kubernetes a usar"
  type        = string
  default     = null
}

variable "dns_prefix" {
  description = "Prefijo DNS para el cluster"
  type        = string
}

variable "private_cluster_enabled" {
  description = "Habilitar cluster privado"
  type        = bool
  default     = false
}

variable "node_pool_name" {
  description = "Nombre del node pool"
  type        = string
  default     = "system"
}

variable "node_vm_size" {
  description = "Tamaño de VM para los nodos"
  type        = string
}

variable "node_disk_size_gb" {
  description = "Tamaño del disco en GB para los nodos"
  type        = number
}

variable "node_min_count" {
  description = "Número mínimo de nodos"
  type        = number
}

variable "node_max_count" {
  description = "Número máximo de nodos"
  type        = number
}

variable "enable_auto_scaling" {
  description = "Habilitar auto-scaling del node pool"
  type        = bool
  default     = true
}

variable "enable_log_analytics" {
  description = "Habilitar Log Analytics Workspace para monitoring mejorado"
  type        = bool
  default     = false
}

variable "log_analytics_sku" {
  description = "SKU del Log Analytics Workspace (PerGB2018, Free, etc.)"
  type        = string
  default     = "PerGB2018"
}

variable "enable_backup" {
  description = "Habilitar backup del cluster"
  type        = bool
  default     = false
}

variable "backup_frequency" {
  description = "Frecuencia de backup (Daily, Weekly)"
  type        = string
  default     = "Weekly"
}

variable "backup_retention_days" {
  description = "Días de retención del backup"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags a aplicar a los recursos"
  type        = map(string)
  default     = {}
}

