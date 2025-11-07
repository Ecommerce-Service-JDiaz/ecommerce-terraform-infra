# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${var.resource_prefix}-rg-${var.environment}"
  location = var.location

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "${var.resource_prefix}-vnet-${var.environment}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# Subnet para AKS
resource "azurerm_subnet" "aks" {
  name                 = "${var.resource_prefix}-subnet-aks-${var.environment}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Subnet para nodos del cluster
resource "azurerm_subnet" "nodes" {
  name                 = "${var.resource_prefix}-subnet-nodes-${var.environment}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

