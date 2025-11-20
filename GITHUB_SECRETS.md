# 🔐 GitHub Secrets - Lista Completa y Organizada

Este documento contiene **TODOS** los secrets que debes configurar en GitHub para que el proyecto funcione correctamente.

## 📍 Cómo Agregar Secrets en GitHub

1. Ve a tu repositorio en GitHub
2. **Settings** → **Secrets and variables** → **Actions**
3. Click en **New repository secret**
4. Agrega cada secret de la lista siguiente con el nombre exacto (case-sensitive)

---

## 📊 Tabla de Secrets

| Secret Name | Equivalente | Ejemplo |
|------------|-------------|---------|
| `AZURE_CLIENT_ID` | Service Principal Client ID | `12345678-1234-1234-1234-123456789abc` |
| `AZURE_CLIENT_SECRET` | Service Principal Client Secret | `abc123...` |
| `AZURE_SUBSCRIPTION_ID` | Azure Subscription ID | `a0fde311-6cea-4da3-aacb-34db196ca8d9` |
| `AZURE_TENANT_ID` | Azure Tenant ID | `12345678-1234-1234-1234-123456789abc` |
| `AZURE_STATE_RESOURCE_GROUP` | Resource Group del Storage Account | `tfstate-rg` |
| `AZURE_STATE_STORAGE_ACCOUNT` | Nombre del Storage Account | `tfstatestorage` |
| `AZURE_STATE_CONTAINER` | Nombre del contenedor | `tfstate` |
| `RESOURCE_PREFIX` | Prefijo para nombres de recursos | `ecommerce` |
| `AZURE_LOCATION` | Región de Azure | `eastus2` |
| `CLUSTER_NAME_BASE` | Nombre base del cluster AKS | `aks-cluster` |
| `AZURE_RESOURCE_GROUP_DEV` | Resource Group de Dev | `ecommerce-rg-dev` |
| `AKS_CLUSTER_NAME_DEV` | Cluster AKS de Dev | `aks-cluster-dev` |
| `AZURE_RESOURCE_GROUP_STAGE` | Resource Group de Stage | `ecommerce-rg-stage` |
| `AKS_CLUSTER_NAME_STAGE` | Cluster AKS de Stage | `aks-cluster-stage` |
| `AZURE_RESOURCE_GROUP_PROD` | Resource Group de Prod | `ecommerce-rg-prod` |
| `AKS_CLUSTER_NAME_PROD` | Cluster AKS de Prod | `aks-cluster-prod` |
| `DOCKERHUB_USERNAME` | Usuario de Docker Hub | `sebastian411` |
| `DOCKERHUB_TOKEN` | Token/Password de Docker Hub | `k(-_)=.?qvC4qdT` |
| `SPRING_CLOUD_CONFIG_SERVER_GIT_URI` | URI del repositorio Git | `https://github.com/Ecommerce-Service-JDiaz/ecommerce-cloud-config-server` |
| `SPRING_CLOUD_CONFIG_SERVER_GIT_DEFAULT_LABEL` | Rama por defecto del repositorio | `main` |
| `EUREKA_CLIENT_SERVICEURL_DEFAULTZONE` | URL del servicio Eureka Client Default Zone | `http://eureka-server:8761/eureka/` |
| `AZURE_CREDENTIAL` | Credencial adicional de Azure (JSON) | `{"clientId":"...","clientSecret":"..."}` |

---

## 📋 Lista Completa de Secrets (22 Secrets)

### 🔑 1. Autenticación de Azure (Service Principal) - 4 Secrets

| # | Secret Name | Descripción | Ejemplo | Cómo Obtenerlo |
|---|------------|-------------|---------|----------------|
| 1 | `AZURE_CLIENT_ID` | Client ID del Service Principal | `12345678-1234-1234-1234-123456789abc` | Del output de `az ad sp create-for-rbac` |
| 2 | `AZURE_CLIENT_SECRET` | Client Secret del Service Principal | `abc123...` | Del output de `az ad sp create-for-rbac` |
| 3 | `AZURE_SUBSCRIPTION_ID` | ID de la suscripción de Azure | `a0fde311-6cea-4da3-aacb-34db196ca8d9` | `az account show --query id -o tsv` |
| 4 | `AZURE_TENANT_ID` | ID del tenant de Azure | `12345678-1234-1234-1234-123456789abc` | Del output de `az ad sp create-for-rbac` |

### 💾 2. Terraform Backend (Azure Storage) - 3 Secrets

| # | Secret Name | Descripción | Ejemplo | Cómo Obtenerlo |
|---|------------|-------------|---------|----------------|
| 5 | `AZURE_STATE_RESOURCE_GROUP` | Resource Group del Storage Account | `tfstate-rg` | El que creaste para el backend |
| 6 | `AZURE_STATE_STORAGE_ACCOUNT` | Nombre del Storage Account | `tfstatestorage` | El que creaste para el backend |
| 7 | `AZURE_STATE_CONTAINER` | Nombre del contenedor | `tfstate` | El que creaste para el backend |

### 🏗️ 3. Configuración General del Proyecto - 3 Secrets

| # | Secret Name | Descripción | Ejemplo | Valor Recomendado |
|---|------------|-------------|---------|-------------------|
| 8 | `RESOURCE_PREFIX` | Prefijo para nombres de recursos | `ecommerce` | `ecommerce` |
| 9 | `AZURE_LOCATION` | Región de Azure | `eastus2` | `eastus2` |
| 10 | `CLUSTER_NAME_BASE` | Nombre base del cluster AKS | `aks-cluster` | `aks-cluster` |

### 📦 4. Resource Groups y Cluster Names - 6 Secrets

| # | Secret Name | Descripción | Ejemplo | Valor Recomendado |
|---|------------|-------------|---------|-------------------|
| 11 | `AZURE_RESOURCE_GROUP_DEV` | Nombre del Resource Group de Dev | `ecommerce-rg-dev` | `ecommerce-rg-dev` |
| 12 | `AKS_CLUSTER_NAME_DEV` | Nombre del cluster AKS de Dev | `aks-cluster-dev` | `aks-cluster-dev` |
| 13 | `AZURE_RESOURCE_GROUP_STAGE` | Nombre del Resource Group de Stage | `ecommerce-rg-stage` | `ecommerce-rg-stage` |
| 14 | `AKS_CLUSTER_NAME_STAGE` | Nombre del cluster AKS de Stage | `aks-cluster-stage` | `aks-cluster-stage` |
| 15 | `AZURE_RESOURCE_GROUP_PROD` | Nombre del Resource Group de Prod | `ecommerce-rg-prod` | `ecommerce-rg-prod` |
| 16 | `AKS_CLUSTER_NAME_PROD` | Nombre del cluster AKS de Prod | `aks-cluster-prod` | `aks-cluster-prod` |

### 🐳 5. Docker Hub - 2 Secrets

| # | Secret Name | Descripción | Ejemplo | Cómo Obtenerlo |
|---|------------|-------------|---------|----------------|
| 17 | `DOCKERHUB_USERNAME` | Usuario de Docker Hub | `sebastian411` | Tu usuario de Docker Hub |
| 18 | `DOCKERHUB_TOKEN` | Token/Password de Docker Hub | `k(-_)=.?qvC4qdT` | Tu token o password de Docker Hub |

### ☁️ 6. Spring Cloud Config Server - 2 Secrets

| # | Secret Name | Descripción | Ejemplo | Valor Actual |
|---|------------|-------------|---------|--------------|
| 19 | `SPRING_CLOUD_CONFIG_SERVER_GIT_URI` | URI del repositorio Git | `https://github.com/Ecommerce-Service-JDiaz/ecommerce-cloud-config-server` | `https://github.com/Ecommerce-Service-JDiaz/ecommerce-cloud-config-server` |
| 20 | `SPRING_CLOUD_CONFIG_SERVER_GIT_DEFAULT_LABEL` | Rama por defecto del repositorio | `main` | `main` |

### 🔍 7. Eureka Client - 1 Secret

| # | Secret Name | Descripción | Ejemplo | Notas |
|---|------------|-------------|---------|-------|
| 21 | `EUREKA_CLIENT_SERVICEURL_DEFAULTZONE` | URL del servicio Eureka Client Default Zone | `http://eureka-server:8761/eureka/` | URL completa del servicio Eureka |

### 🔧 8. Opcional - 1 Secret

| # | Secret Name | Descripción | Ejemplo | Notas |
|---|------------|-------------|---------|-------|
| 22 | `AZURE_CREDENTIAL` | Credencial adicional de Azure (JSON) | `{"clientId":"...","clientSecret":"..."}` | Opcional, solo si necesitas credenciales adicionales |

---

## ✅ Checklist de Configuración

Usa este checklist para asegurarte de que tienes todos los secrets configurados:

### Autenticación Azure (4)
- [ ] `AZURE_CLIENT_ID`
- [ ] `AZURE_CLIENT_SECRET`
- [ ] `AZURE_SUBSCRIPTION_ID`
- [ ] `AZURE_TENANT_ID`

### Terraform Backend (3)
- [ ] `AZURE_STATE_RESOURCE_GROUP`
- [ ] `AZURE_STATE_STORAGE_ACCOUNT`
- [ ] `AZURE_STATE_CONTAINER`

### Configuración General (3)
- [ ] `RESOURCE_PREFIX`
- [ ] `AZURE_LOCATION`
- [ ] `CLUSTER_NAME_BASE`

### Resource Groups y Clusters (6)
- [ ] `AZURE_RESOURCE_GROUP_DEV`
- [ ] `AKS_CLUSTER_NAME_DEV`
- [ ] `AZURE_RESOURCE_GROUP_STAGE`
- [ ] `AKS_CLUSTER_NAME_STAGE`
- [ ] `AZURE_RESOURCE_GROUP_PROD`
- [ ] `AKS_CLUSTER_NAME_PROD`

### Docker Hub (2)
- [ ] `DOCKERHUB_USERNAME`
- [ ] `DOCKERHUB_TOKEN`

### Spring Cloud Config (2)
- [ ] `SPRING_CLOUD_CONFIG_SERVER_GIT_URI`
- [ ] `SPRING_CLOUD_CONFIG_SERVER_GIT_DEFAULT_LABEL`

### Eureka Client (1)
- [ ] `EUREKA_CLIENT_SERVICEURL_DEFAULTZONE`

### Opcional (1)
- [ ] `AZURE_CREDENTIAL` (opcional)

**Total: 21 Secrets Requeridos + 1 Opcional = 22 Secrets**

---

## 📝 Valores Recomendados Basados en tu Configuración Actual

### Configuración General
```
RESOURCE_PREFIX = "ecommerce"
AZURE_LOCATION = "eastus2"
CLUSTER_NAME_BASE = "aks-cluster"
```

### Resource Groups
```
AZURE_RESOURCE_GROUP_DEV = "ecommerce-rg-dev"
AZURE_RESOURCE_GROUP_STAGE = "ecommerce-rg-stage"
AZURE_RESOURCE_GROUP_PROD = "ecommerce-rg-prod"
```

### Cluster Names
```
AKS_CLUSTER_NAME_DEV = "aks-cluster-dev"
AKS_CLUSTER_NAME_STAGE = "aks-cluster-stage"
AKS_CLUSTER_NAME_PROD = "aks-cluster-prod"
```

### Spring Cloud Config
```
SPRING_CLOUD_CONFIG_SERVER_GIT_URI = "https://github.com/Ecommerce-Service-JDiaz/ecommerce-cloud-config-server"
SPRING_CLOUD_CONFIG_SERVER_GIT_DEFAULT_LABEL = "main"
```

### Eureka Client
```
EUREKA_CLIENT_SERVICEURL_DEFAULTZONE = "http://eureka-server:8761/eureka/"
```

### Docker Hub
```
DOCKERHUB_USERNAME = "sebastian411"
DOCKERHUB_TOKEN = "<tu-token>"
```

---

## 🔍 Cómo Verificar que los Secrets Están Configurados

1. Ve a **Settings** → **Secrets and variables** → **Actions**
2. Deberías ver todos los 21 secrets requeridos listados
3. Si falta alguno, el workflow fallará con un mensaje específico indicando cuál falta

---

## ⚠️ Notas Importantes

1. **Nunca commits secrets en el código**: Todos los valores sensibles deben estar solo en GitHub Secrets
2. **Los secrets son sensibles**: No compartas estos valores públicamente
3. **Case-sensitive**: Los nombres de los secrets son case-sensitive, usa exactamente los nombres mostrados
4. **Sin espacios**: No agregues espacios al inicio o final de los valores
5. **Valores actuales**: Los valores como `SPRING_CLOUD_CONFIG_SERVER_GIT_URI` ya están definidos en el código, pero deben estar también en secrets para el Key Vault y para poder cambiarlos fácilmente

---

## 🚀 Después de Configurar los Secrets

Una vez que hayas agregado todos los secrets:

1. Haz commit y push de tus cambios
2. El workflow se ejecutará automáticamente en el próximo push a `main`
3. O ejecuta manualmente desde **Actions** → **Deploy Infrastructure** → **Run workflow**

Si algún secret falta, el workflow te indicará exactamente cuál falta en el log de error.

---

## 📚 Referencias

- [GitHub Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [Azure Service Principal](https://docs.microsoft.com/en-us/azure/active-directory/develop/app-objects-and-service-principals)
- [Terraform Azure Backend](https://www.terraform.io/docs/language/settings/backends/azurerm.html)
