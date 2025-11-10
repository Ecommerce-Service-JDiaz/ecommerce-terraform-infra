variable "kube_config_host" {
  description = "Host del cluster Kubernetes"
  type        = string
  sensitive   = true
}

variable "kube_config_client_certificate" {
  description = "Client certificate del cluster Kubernetes (base64 encoded)"
  type        = string
  sensitive   = true
}

variable "kube_config_client_key" {
  description = "Client key del cluster Kubernetes (base64 encoded)"
  type        = string
  sensitive   = true
}

variable "kube_config_cluster_ca_certificate" {
  description = "Cluster CA certificate del cluster Kubernetes (base64 encoded)"
  type        = string
  sensitive   = true
}

variable "namespace" {
  description = "Namespace donde se creará el ConfigMap"
  type        = string
  default     = "default"
}

