resource "azurerm_resource_group" "aks_resources" {
  name     = "AKSResources"
  location = var.location

  tags = var.tags
}

resource "azurerm_virtual_network" "aks_vnet" {
  name                = "AKSVirtualNetwork"
  location            = var.location
  resource_group_name = azurerm_resource_group.aks_resources.name
  address_space       = ["10.150.0.0/16"]

#  subnet {
#    name           = "AKSSubnet"
#    address_prefix = "10.150.20.0/24"
#  }

  tags = var.tags
}

resource "azurerm_subnet" "aks_vnet_subnet" {
    name                 = "AKSSubnet"
    resource_group_name  = azurerm_resource_group.aks_resources.name
    virtual_network_name = azurerm_virtual_network.aks_vnet.name
    address_prefixes     = ["10.150.20.0/24"]
}

resource "azurerm_user_assigned_identity" "managed_identity" {
  location            = var.location
  name                = "AKSIdentity"
  resource_group_name = azurerm_resource_group.aks_resources.name
  tags                = var.tags
}

resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  location            = var.location
  name                = "AKSCluster"
  resource_group_name = azurerm_resource_group.aks_resources.name
  dns_prefix          = "akstest"
  tags                = var.tags

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.240.0.0/24"
    dns_service_ip = "10.240.0.10"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.managed_identity.id]
  }

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_B2s"
    vnet_subnet_id = azurerm_subnet.aks_vnet_subnet.id
  }
}