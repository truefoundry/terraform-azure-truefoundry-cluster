#!/bin/bash

# Cluster
terraform state mv 'azurerm_role_assignment.network_contributor_cluster' 'azurerm_role_assignment.network_contributor_cluster[0]'
terraform state mv 'azurerm_user_assigned_identity.cluster' 'azurerm_user_assigned_identity.cluster[0]'
terraform state mv 'module.aks.azapi_update_resource.aks_cluster_post_create' 'module.aks[0].azapi_update_resource.aks_cluster_post_create'
terraform state mv 'module.aks.azurerm_kubernetes_cluster.main' 'module.aks[0].azurerm_kubernetes_cluster.main'
terraform state mv 'module.aks.azurerm_log_analytics_solution.main[0]' 'module.aks[0].azurerm_log_analytics_solution.main[0]'
terraform state mv 'module.aks.azurerm_log_analytics_workspace.main[0]' 'module.aks[0].azurerm_log_analytics_workspace.main[0]'
terraform state mv 'module.aks.null_resource.kubernetes_cluster_name_keeper' 'module.aks[0].null_resource.kubernetes_cluster_name_keeper'
terraform state mv 'module.aks.null_resource.kubernetes_version_keeper' 'module.aks[0].null_resource.kubernetes_version_keeper'


####################################################################################################################################
# NOTE: The node pools state migration commands may fail depending upon the nodepools chosen.
####################################################################################################################################

# Node pools
terraform state mv 'module.aks.azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["a10"]' 'module.aks[0].azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["a10"]'
terraform state mv 'module.aks.azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["a100"]' 'module.aks[0].azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["a100"]'
terraform state mv 'module.aks.azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["a100sp"]' 'module.aks[0].azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["a100sp"]'
terraform state mv 'module.aks.azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["a10sp"]' 'module.aks[0].azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["a10sp"]'
terraform state mv 'module.aks.azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["cpu"]' 'module.aks[0].azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["cpu"]'
terraform state mv 'module.aks.azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["cpu2x"]' 'module.aks[0].azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["cpu2x"]'
terraform state mv 'module.aks.azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["cpu2xsp"]' 'module.aks[0].azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["cpu2xsp"]'
terraform state mv 'module.aks.azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["cpusp"]' 'module.aks[0].azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["cpusp"]'
terraform state mv 'module.aks.azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["t4"]' 'module.aks[0].azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["t4"]'
terraform state mv 'module.aks.azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["t4sp"]' 'module.aks[0].azurerm_kubernetes_cluster_node_pool.node_pool_create_before_destroy["t4sp"]'
terraform state mv 'module.aks.null_resource.pool_name_keeper["a10"]' 'module.aks[0].null_resource.pool_name_keeper["a10"]'
terraform state mv 'module.aks.null_resource.pool_name_keeper["a100"]' 'module.aks[0].null_resource.pool_name_keeper["a100"]'
terraform state mv 'module.aks.null_resource.pool_name_keeper["a100sp"]' 'module.aks[0].null_resource.pool_name_keeper["a100sp"]'
terraform state mv 'module.aks.null_resource.pool_name_keeper["a10sp"]' 'module.aks[0].null_resource.pool_name_keeper["a10sp"]'
terraform state mv 'module.aks.null_resource.pool_name_keeper["cpu"]' 'module.aks[0].null_resource.pool_name_keeper["cpu"]'
terraform state mv 'module.aks.null_resource.pool_name_keeper["cpu2x"]' ' module.aks[0].null_resource.pool_name_keeper["cpu2x"]'
terraform state mv 'module.aks.null_resource.pool_name_keeper["cpu2xsp"]' 'module.aks[0].null_resource.pool_name_keeper["cpu2xsp"]'
terraform state mv 'module.aks.null_resource.pool_name_keeper["cpusp"]' 'module.aks[0].null_resource.pool_name_keeper["cpusp"]'
terraform state mv 'module.aks.null_resource.pool_name_keeper["t4"]' 'module.aks[0].null_resource.pool_name_keeper["t4"]'
terraform state mv 'module.aks.null_resource.pool_name_keeper["t4sp"]' 'module.aks[0].null_resource.pool_name_keeper["t4sp"]'