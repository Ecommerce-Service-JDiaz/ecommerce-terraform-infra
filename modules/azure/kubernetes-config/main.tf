terraform {
  required_version = ">= 1.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  host                   = var.kube_config_host
  client_certificate     = base64decode(var.kube_config_client_certificate)
  client_key             = base64decode(var.kube_config_client_key)
  cluster_ca_certificate  = base64decode(var.kube_config_cluster_ca_certificate)
}

# ConfigMap con variables de entorno para Spring Boot
resource "kubernetes_config_map" "spring_env_config" {
  metadata {
    name      = "spring-env-config"
    namespace = var.namespace
  }

  data = {
    SPRING_ZIPKIN_BASE_URL                    = "http://zipkin:9411"
    SPRING_CONFIG_IMPORT                       = "http://cloud-config-service:9296"
    EUREKA_CLIENT_SERVICEURL_DEFAULTZONE       = "http://service-discovery:8761/eureka"
  }
}

