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
}
