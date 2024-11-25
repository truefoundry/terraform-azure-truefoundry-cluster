data "azurerm_kubernetes_cluster" "cluster" {
  count               = var.use_existing_cluster ? 1 : 0
  name                = var.name
  resource_group_name = var.resource_group_name
}