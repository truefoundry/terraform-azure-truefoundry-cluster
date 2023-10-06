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

module "aks" {
  source                    = "Azure/aks/azurerm"
  version                   = "7.4.0"
  resource_group_name       = var.resource_group_name
  cluster_name              = var.name
  location                  = var.location
  prefix                    = "tfy"
  workload_identity_enabled = var.workload_identity_enabled

  # agent configuration
  # agents_availability_zones = []
  agents_labels = {
    "truefoundry" : "essential"
  }
  agents_count     = local.intial_node_pool_min_count
  agents_max_count = local.intial_node_pool_max_count
  agents_min_count = local.intial_node_pool_min_count
  agents_pool_name = "initial"
  agents_size      = var.intial_node_pool_instance_type
  agents_tags      = local.tags

  # autoscaler configuration
  auto_scaler_profile_enabled                          = true
  auto_scaler_profile_expander                         = "random"
  auto_scaler_profile_max_graceful_termination_sec     = "180"
  auto_scaler_profile_max_node_provisioning_time       = "5m"
  auto_scaler_profile_max_unready_nodes                = 0
  auto_scaler_profile_scale_down_delay_after_add       = "2m"
  auto_scaler_profile_scale_down_delay_after_delete    = "30s"
  auto_scaler_profile_scale_down_unneeded              = "1m"
  auto_scaler_profile_scale_down_unready               = "2m"
  auto_scaler_profile_scale_down_utilization_threshold = "0.3"

  # cluster level configurations
  api_server_authorized_ip_ranges            = var.allowed_ip_ranges
  create_role_assignment_network_contributor = false
  enable_auto_scaling                        = true
  enable_host_encryption                     = true
  identity_ids                               = [azurerm_user_assigned_identity.cluster.id]
  identity_type                              = "UserAssigned"
  kubernetes_version                         = var.kubernetes_version

  # storage
  storage_profile_blob_driver_enabled         = var.enable_blob_driver
  storage_profile_disk_driver_enabled         = var.enable_disk_driver
  storage_profile_disk_driver_version         = var.disk_driver_version
  storage_profile_file_driver_enabled         = var.enable_file_driver
  storage_profile_snapshot_controller_enabled = var.enable_snapshot_controller
  storage_profile_enabled                     = var.enable_storage_profile

  # network configuration
  network_plugin             = var.network_plugin
  vnet_subnet_id             = var.subnet_id
  net_profile_dns_service_ip = var.dns_ip
  net_profile_service_cidr   = var.service_cidr
  net_profile_pod_cidr       = var.pod_cidr
  # net_profile_docker_bridge_cidr = "10.244.0.10"

  node_pools = local.node_pools

  oidc_issuer_enabled = var.oidc_issuer_enabled
  os_disk_size_gb     = var.disk_size

  # makes the initial node pool have a taint `CriticalAddonsOnly=true:NoSchedule`
  # helpful in scheduling important workloads 
  only_critical_addons_enabled = true

  private_cluster_enabled = var.private_cluster_enabled

  # rbac 
  rbac_aad                          = false
  role_based_access_control_enabled = false

  tags = local.tags
}