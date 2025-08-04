resource "azurerm_user_assigned_identity" "cluster" {
  count               = var.use_existing_cluster ? 0 : 1
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
}

# https://learn.microsoft.com/en-us/azure/aks/configure-kubenet#add-role-assignment-for-managed-identity
resource "azurerm_role_assignment" "network_contributor_cluster" {
  count                = var.use_existing_cluster ? 0 : 1
  scope                = var.vnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.cluster[0].principal_id
}

module "aks" {
  count                       = var.use_existing_cluster ? 0 : 1
  source                      = "Azure/aks/azurerm"
  version                     = "10.2.0"
  resource_group_name         = var.resource_group_name
  cluster_name                = var.name
  location                    = var.location
  prefix                      = "tfy"
  workload_identity_enabled   = var.workload_identity_enabled
  temporary_name_for_rotation = "tmpdefault"

  log_analytics_workspace_enabled                             = var.log_analytics_workspace_enabled
  cluster_log_analytics_workspace_name                        = local.log_analytics_workspace_name
  cost_analysis_enabled                                       = var.cluster_cost_analysis_enabled
  create_monitor_data_collection_rule                         = var.cluster_monitor_data_collection_rule_enabled
  monitor_data_collection_rule_data_sources_syslog_facilities = var.cluster_monitor_data_collection_rule_data_sources_syslog_facilities
  monitor_data_collection_rule_data_sources_syslog_levels     = var.cluster_monitor_data_collection_rule_data_sources_syslog_levels
  monitor_data_collection_rule_extensions_streams             = var.cluster_monitor_data_collection_rule_extensions_streams
  monitor_metrics                                             = var.cluster_monitor_metrics

  agents_pool_name      = var.initial_node_pool_name
  agents_count          = var.enable_auto_scaling ? null : var.initial_node_pool_count
  agents_max_count      = var.enable_auto_scaling ? var.initial_node_pool_max_count : null
  agents_min_count      = var.enable_auto_scaling ? var.initial_node_pool_min_count : null
  agents_size           = var.initial_node_pool_instance_type
  agents_max_pods       = var.max_pods_per_node
  agents_pool_max_surge = var.initial_node_pool_max_surge
  agents_tags           = local.tags

  orchestrator_version = var.orchestrator_version

  # autoscaler configuration
  auto_scaler_profile_enabled                          = var.enable_autoscaler_profile
  auto_scaler_profile_expander                         = var.autoscaler_profile_expander
  auto_scaler_profile_max_graceful_termination_sec     = var.autoscaler_profile_max_graceful_termination_sec
  auto_scaler_profile_max_node_provisioning_time       = var.autoscaler_profile_max_node_provisioning_time
  auto_scaler_profile_max_unready_nodes                = var.autoscaler_profile_max_unready_nodes
  auto_scaler_profile_scale_down_delay_after_add       = var.autoscaler_profile_scale_down_delay_after_add
  auto_scaler_profile_scale_down_delay_after_delete    = var.autoscaler_profile_scale_down_delay_after_delete
  auto_scaler_profile_scale_down_unneeded              = var.autoscaler_profile_scale_down_unneeded
  auto_scaler_profile_scale_down_unready               = var.autoscaler_profile_scale_down_unready
  auto_scaler_profile_scale_down_utilization_threshold = var.autoscaler_profile_scale_down_utilization_threshold
  auto_scaler_profile_skip_nodes_with_system_pods      = var.autoscaler_profile_skip_nodes_with_system_pods
  auto_scaler_profile_skip_nodes_with_local_storage    = var.autoscaler_profile_skip_nodes_with_local_storage

  # cluster level configurations
  api_server_authorized_ip_ranges            = var.allowed_ip_ranges
  create_role_assignment_network_contributor = false # false because AKS will not create role assignment for each nodepool's subnet
  enable_auto_scaling                        = var.enable_auto_scaling
  enable_host_encryption                     = true
  identity_ids                               = [azurerm_user_assigned_identity.cluster[0].id]
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
  network_plugin_mode        = var.network_plugin_mode
  network_data_plane         = var.network_data_plane
  vnet_subnet                = { id = var.subnet_id }
  net_profile_dns_service_ip = var.dns_ip
  net_profile_service_cidr   = var.service_cidr
  net_profile_pod_cidr       = var.pod_cidr

  node_pools = local.node_pools

  oidc_issuer_enabled     = var.oidc_issuer_enabled
  os_disk_size_gb         = var.disk_size
  private_cluster_enabled = var.private_cluster_enabled

  # rbac 
  rbac_aad                          = var.rbac_aad
  rbac_aad_azure_rbac_enabled       = var.rbac_aad_azure_rbac_enabled
  role_based_access_control_enabled = var.role_based_access_control_enabled

  sku_tier = var.sku_tier
  tags     = local.tags
}

resource "azurerm_monitor_diagnostic_setting" "cluster_autoscaler_diagnostic" {
  count              = var.use_existing_cluster ? 0 : var.log_analytics_workspace_enabled ? 1 : 0
  name               = local.log_analytics_cluster_autoscaler_diagnostic_name
  target_resource_id = module.aks[0].aks_id

  log_analytics_workspace_id     = module.aks[0].azurerm_log_analytics_workspace_id
  log_analytics_destination_type = "Dedicated"

  enabled_log {
    category = "cluster-autoscaler"
  }

  lifecycle {
    ignore_changes = [metric]
  }
}
