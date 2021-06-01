provider "azurerm" {
  version = "=1.5.0"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "grilo" {
  name                = "grilo-aks1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "griloaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
}

output "kubeconfig" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw
}
    
output "cluster_url" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.host
}
