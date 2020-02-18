#####################################
## Azure Kubernetes Service - Main ##
#####################################

# Create a Resource Group for AKS
resource "azurerm_resource_group" "k8s-rg" {
  name     = "${var.company}-${var.environment}-aks-rg"
  location = var.location
}

# Create a randon string for log analytics workspace name suffix
resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

# Log analytics workspace - The workspace name has to be globally unique
resource "azurerm_log_analytics_workspace" "k8s-log-workspace" {
  name                = "${var.company}-${var.environment}-aks-log-analytics-workspace-${random_id.log_analytics_workspace_name_suffix.dec}"
  location            = var.log_analytics_workspace_location
  resource_group_name = azurerm_resource_group.k8s-rg.name
  sku                 = var.log_analytics_workspace_sku
}

# Log analytics solution - Container Insights
resource "azurerm_log_analytics_solution" "k8s-log-solution" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.k8s-log-workspace.location
  resource_group_name   = azurerm_resource_group.k8s-rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.k8s-log-workspace.id
  workspace_name        = azurerm_log_analytics_workspace.k8s-log-workspace.name
  
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

# Create Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "k8s-cluster" {
  name                = "${var.company}-${var.environment}-aks-cluster"
  location            = azurerm_resource_group.k8s-rg.location
  resource_group_name = azurerm_resource_group.k8s-rg.name
  dns_prefix          = var.dns_prefix

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name            = "agentpool"
    node_count      = var.default_node_count
    vm_size         = var.default_node_size
    os_disk_size_gb = var.default_node_disk_size
  }

  service_principal {
    client_id     = var.azure-client-id
    client_secret = var.azure-client-secret
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.k8s-log-workspace.id
    }
  }

  tags = {
    Application = var.application
    Environment = var.environment
  }
}