provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "devops" {
  name     = "DevOpsGroup"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "MyAKSCluster"
  resource_group_name = azurerm_resource_group.devops.name
  location            = azurerm_resource_group.devops.location
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }
}
