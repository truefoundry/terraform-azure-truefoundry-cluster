resource "azurerm_user_assigned_identity" "cluster" {
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
}

# Not sure why it is needed but its mentioned https://learn.microsoft.com/en-us/azure/aks/configure-kubenet#add-role-assignment-for-managed-identity
resource "azurerm_role_assignment" "network_contributor_cluster" {
  scope                = var.vnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.cluster.principal_id
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  private_cluster_enabled = var.private_cluster_enabled
  # Additional node pools can be added separately - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool
  default_node_pool {
    name                = "default"
    vm_size             = "Standard_D2_v2"
    enable_auto_scaling = true
    max_count           = 10
    min_count           = 2
    os_disk_size_gb     = 40
    vnet_subnet_id      = var.subnet_id
  }
  oidc_issuer_enabled    = true
  local_account_disabled = false
  dns_prefix             = var.name
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.cluster.id]
  }
  network_profile {
    network_plugin = "kubenet"
  }
}
