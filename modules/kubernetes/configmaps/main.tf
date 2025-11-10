# ConfigMap para variables de entorno de Spring Boot
# Estas variables se usarán en los deployments de las aplicaciones Spring Boot

resource "kubernetes_config_map" "spring_env" {
  provider = kubernetes.aks
  
  metadata {
    name      = "spring-env-config"
    namespace = "default"
    labels = {
      app     = "spring-config"
      managed = "terraform"
    }
  }

  data = {
    SPRING_ZIPKIN_BASE_URL                = "http://zipkin:9411"
    SPRING_CONFIG_IMPORT                   = "http://cloud-config-service:9296"
    EUREKA_CLIENT_SERVICEURL_DEFAULTZONE   = "http://service-discovery:8761/eureka"
  }
}

