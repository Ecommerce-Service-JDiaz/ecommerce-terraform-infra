# Infraestructura como Código - Multicloud Kubernetes

Este proyecto contiene la infraestructura como código (IaC) para desplegar clusters de Kubernetes en múltiples proveedores de nube (Azure, AWS, GCP) y múltiples entornos.

**Estado actual**: Implementado para Azure (AKS). Estructura preparada para AWS (EKS) y GCP (GKE).

## Estructura del Proyecto

```
ecommerce-terraform-infra/
├── main.tf                 # Configuración principal de Terraform y providers
├── variables.tf            # Variables generales
├── outputs.tf              # Outputs del cluster
├── terraform.tfvars.example # Ejemplo de valores por entorno
├── modules/
│   ├── azure/
│   │   └── aks/
│   │       ├── main.tf         # Recursos principales de AKS
│   │       ├── variables.tf    # Variables del módulo
│   │       ├── outputs.tf     # Outputs del módulo
│   │       └── network.tf     # Recursos de red (VNet, subnets)
│   ├── aws/                 # Futuro: módulos para AWS (EKS)
│   └── gcp/                 # Futuro: módulos para GCP (GKE)
└── environments/
    ├── dev/
    │   └── terraform.tfvars
    ├── stage/
    │   └── terraform.tfvars
    └── prod/
        └── terraform.tfvars
```

## Características por Entorno

### Dev
- **Nodos**: 1-3 (min: 1, max: 3) - Ajustado a cuota de 6 vCPUs
- **VM Size**: Standard_F2s_v2 (2 vCPUs, 4 GB RAM - Optimizada para compute)
- **Disk Size**: 128GB
- **Auto-scaling**: Habilitado
- **Monitoring**: Azure Monitor básico (integrado)
- **Backup**: No
- **SLA**: N/A

### Stage
- **Nodos**: 1-3 (min: 1, max: 3) - Ajustado a cuota de 6 vCPUs
- **VM Size**: Standard_F2s_v2 (2 vCPUs, 4 GB RAM - Optimizada para compute)
- **Disk Size**: 256GB
- **Auto-scaling**: Habilitado
- **Monitoring**: Azure Monitor básico (integrado)
- **Backup**: Semanal
- **SLA**: 95%

### Prod
- **Nodos**: 1-3 (min: 1, max: 3) - Ajustado a cuota de 6 vCPUs
- **VM Size**: Standard_F2s_v2 (2 vCPUs, 4 GB RAM - Optimizada para compute)
- **Disk Size**: 256GB
- **Auto-scaling**: Habilitado
- **Monitoring**: Azure Monitor mejorado (Log Analytics Workspace)
- **Backup**: Diario
- **SLA**: 99.9%

> **⚠️ Nota sobre Cuota**: La configuración actual está ajustada a una cuota de 6 vCPUs. Si tu cuota es por ambiente, puedes aumentar los valores. Si es cuota total, solo un ambiente puede estar desplegado a la vez con esta configuración.

## Requisitos Previos

1. **Azure CLI** instalado y configurado
2. **Terraform** >= 1.0 instalado
3. **Permisos de Azure** para crear recursos (Contributor o superior)
4. **Suscripción de Azure** activa
5. **GitHub Repository** (para CI/CD)

## Configuración Inicial

> **Nota**: Este proyecto está diseñado para ejecutarse únicamente mediante GitHub Actions (CI/CD). No se requiere configuración local de Terraform.

### 1. Configurar Backend de Terraform (Remote State)

El estado de Terraform se almacena en Azure Storage Account. Debes crear estos recursos manualmente antes de ejecutar los pipelines:

```bash
# Crear Resource Group
az group create --name tfstate-rg --location eastus2

# Crear Storage Account (el nombre debe ser único globalmente)
az storage account create \
  --resource-group tfstate-rg \
  --name tfstatestorage$(openssl rand -hex 4) \
  --sku Standard_LRS \
  --encryption-services blob

# Crear Container
az storage container create \
  --name tfstate \
  --account-name <STORAGE_ACCOUNT_NAME>
```

### 2. Crear Service Principal para GitHub Actions

```bash
# Login a Azure
az login

# Selecciona tu suscripción
az account set --subscription "TU-SUBSCRIPTION-ID"

# Crea el Service Principal con permisos de Contributor
az ad sp create-for-rbac \
  --name "terraform-github-actions" \
  --role "Contributor" \
  --scopes /subscriptions/$(az account show --query id -o tsv) \
  --sdk-auth
```

Guarda el output del comando anterior, necesitarás:
- `clientId` → `AZURE_CLIENT_ID`
- `clientSecret` → `AZURE_CLIENT_SECRET`
- `subscriptionId` → `AZURE_SUBSCRIPTION_ID`
- `tenantId` → `AZURE_TENANT_ID`

### 3. Configurar GitHub Secrets

Ve a **Settings → Secrets and variables → Actions** en tu repositorio y agrega:

- `AZURE_CLIENT_ID`
- `AZURE_CLIENT_SECRET`
- `AZURE_SUBSCRIPTION_ID`
- `AZURE_TENANT_ID`
- `AZURE_STATE_RESOURCE_GROUP`
- `AZURE_STATE_STORAGE_ACCOUNT`
- `AZURE_STATE_CONTAINER`

**Ver documentación completa:** [GITHUB_SECRETS.md](GITHUB_SECRETS.md)

### 4. Configurar GitHub Environments (Opcional pero Recomendado)

Para proteger los entornos de producción:

1. Ve a **Settings → Environments**
2. Crea los siguientes environments:
   - `dev`
   - `stage`
   - `prod`
   - `prod-destroy` (para el workflow de destroy)

3. Para `prod` y `prod-destroy`, puedes agregar:
   - **Required reviewers**: Personas que deben aprobar antes de desplegar
   - **Wait timer**: Tiempo de espera antes de ejecutar

## Uso

### Despliegue con GitHub Actions (CI/CD)

Los pipelines de GitHub Actions están configurados para desplegar automáticamente:

1. **Deploy Automático:**
   - Push a `main` → despliega a **prod**
   - Push a `develop` → despliega a **stage**
   - Pull Request → ejecuta `terraform plan` (solo revisión)

2. **Deploy Manual:**
   - Ve a **Actions → Deploy Infrastructure → Run workflow**
   - Selecciona el entorno (dev, stage, prod)
   - Click en **Run workflow**

3. **Destroy (Manual con confirmación):**
   - Ve a **Actions → Destroy Infrastructure → Run workflow**
   - Selecciona el entorno
   - Escribe **"DESTROY"** para confirmar
   - ⚠️ **CUIDADO**: Esto eliminará toda la infraestructura

> **Nota**: Los despliegues solo se realizan mediante GitHub Actions. No se recomienda ejecutar Terraform localmente para este proyecto.

### Conectar al Cluster

Después del despliegue, puedes conectarte al cluster usando:

```bash
az aks get-credentials --resource-group <resource-group-name> --name <cluster-name>
```

O usando el output de Terraform:

```bash
terraform output -raw kube_config_command
```

## Variables Principales

- `environment`: Entorno de despliegue (dev, stage, prod)
- `location`: Región de Azure (default: eastus2)
- `resource_prefix`: Prefijo para nombres de recursos
- `cluster_name`: Nombre del cluster AKS
- `node_vm_size`: Tamaño de VM para los nodos
- `node_disk_size_gb`: Tamaño del disco en GB
- `node_min_count`: Número mínimo de nodos
- `node_max_count`: Número máximo de nodos
- `enable_log_analytics`: Habilitar Log Analytics (solo Prod)
- `enable_backup`: Habilitar backup (Stage y Prod)

## Recursos Creados

Por cada entorno se crean los siguientes recursos:

- Resource Group
- Virtual Network (VNet) con subnets
- Azure Kubernetes Service (AKS) cluster
- Node Pool con auto-scaling configurado
- Log Analytics Workspace (solo Prod)
- Recovery Services Vault y Storage Account (Stage y Prod)
- Backup Policy (Stage y Prod)

## Destruir la Infraestructura

Los despliegues solo se destruyen mediante GitHub Actions:

1. Ve a **Actions → Destroy Infrastructure**
2. Click en **Run workflow**
3. Selecciona el entorno
4. Escribe **"DESTROY"** para confirmar
5. Click en **Run workflow**

**⚠️ ADVERTENCIA**: Esto eliminará todos los recursos del entorno especificado.

## Variables de Entorno y Seguridad

### Variables de Entorno para Azure

El provider de Azure usa estas variables de entorno para autenticación:

- `ARM_CLIENT_ID`: Service Principal Client ID
- `ARM_CLIENT_SECRET`: Service Principal Client Secret
- `ARM_SUBSCRIPTION_ID`: Azure Subscription ID
- `ARM_TENANT_ID`: Azure Tenant ID

### Remote State Backend

El estado de Terraform se almacena en Azure Storage Account usando estas variables:

- `ARM_RESOURCE_GROUP_NAME`: Resource Group del Storage Account
- `ARM_STORAGE_ACCOUNT_NAME`: Nombre del Storage Account
- `ARM_CONTAINER_NAME`: Nombre del contenedor (default: tfstate)
- `ARM_STATE_KEY`: Clave del estado (default: terraform.tfstate)

**Nota**: Estas variables se configuran automáticamente en GitHub Actions desde los secrets.

## Notas Importantes

1. **Costos**: Los recursos de Azure generan costos. Revisa los precios antes de desplegar.
2. **Backup**: Los backups están configurados pero requieren configuración adicional para funcionar completamente con AKS.
3. **SLA**: El SLA se logra mediante la selección de SKUs apropiadas y características del cluster.
4. **Versión de Kubernetes**: Si no se especifica, se usará la versión predeterminada de Azure.
5. **Remote State**: El estado se almacena en Azure Storage. No elimines el Storage Account del backend.
6. **Secrets**: Nunca commits credenciales. Usa GitHub Secrets para CI/CD.

## Soporte

Para problemas o preguntas, consulta la documentación de Terraform y Azure AKS.

