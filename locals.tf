locals {
  tags = merge(
    {
      "terraform-module" = "terraform-azure-truefoundry-cluster"
      "terraform"        = "true"
      "cluster-name"     = var.name
      "truefoundry"      = "managed"
    },
    var.tags
  )
  node_pools = merge({ for k, v in var.cpu_pools : "${v["name"]}sp" => {
    name                    = "${v["name"]}sp"
    node_count              = null
    max_count               = v["max_count"]
    min_count               = v["min_count"]
    os_disk_size_gb         = 100
    priority                = "Spot"
    vm_size                 = v["instance_type"]
    enable_auto_scaling     = true
    custom_ca_trust_enabled = false
    enable_host_encryption  = true
    enable_node_public_ip   = false
    eviction_policy         = "Delete"
    orchestrator_version    = var.orchestrator_version
    node_taints = [
      "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
    ]
    tags           = local.tags
    zones          = []
    vnet_subnet_id = var.subnet_id
    max_pods       = var.max_pods_per_node
    } if v["enable_spot_pool"] },
    { for k, v in var.cpu_pools : v["name"] => {
      name                    = v["name"]
      node_count              = null
      max_count               = v["max_count"]
      min_count               = v["min_count"]
      os_disk_size_gb         = 100
      priority                = "Regular"
      vm_size                 = v["instance_type"]
      enable_auto_scaling     = true
      custom_ca_trust_enabled = false
      enable_host_encryption  = true
      enable_node_public_ip   = false
      orchestrator_version    = var.orchestrator_version
      node_taints             = []
      tags                    = local.tags
      zones                   = []
      vnet_subnet_id          = var.subnet_id
      max_pods                = var.max_pods_per_node
    } if v["enable_on_demand_pool"] },

    { for k, v in var.gpu_pools : "${v["name"]}sp" => {
      name                    = "${v["name"]}sp"
      node_count              = null
      max_count               = v["max_count"]
      min_count               = v["min_count"]
      os_disk_size_gb         = 100
      priority                = "Spot"
      vm_size                 = v["instance_type"]
      enable_auto_scaling     = true
      custom_ca_trust_enabled = false
      enable_host_encryption  = true
      enable_node_public_ip   = false
      eviction_policy         = "Delete"
      orchestrator_version    = var.orchestrator_version
      node_taints = [
        "kubernetes.azure.com/scalesetpriority=spot:NoSchedule",
        "nvidia.com/gpu=Present:NoSchedule"
      ]
      tags           = local.tags
      zones          = []
      vnet_subnet_id = var.subnet_id
      max_pods       = var.max_pods_per_node
    } if v["enable_spot_pool"] },
    { for k, v in var.gpu_pools : v["name"] => {
      name                    = v["name"]
      node_count              = null
      max_count               = v["max_count"]
      min_count               = v["min_count"]
      os_disk_size_gb         = 100
      priority                = "Regular"
      vm_size                 = v["instance_type"]
      enable_auto_scaling     = true
      custom_ca_trust_enabled = false
      enable_host_encryption  = true
      enable_node_public_ip   = false
      orchestrator_version    = var.orchestrator_version
      node_taints = [
        "nvidia.com/gpu=Present:NoSchedule"
      ]
      tags           = local.tags
      zones          = []
      vnet_subnet_id = var.subnet_id
      max_pods       = var.max_pods_per_node
    } if v["enable_on_demand_pool"] },
    var.control_plane ? { "tfycp" = {
      name                    = "tfycp"
      node_count              = null
      max_count               = 4
      min_count               = 0
      os_disk_size_gb         = 100
      priority                = "Spot"
      vm_size                 = var.control_plane_instance_type
      enable_auto_scaling     = true
      custom_ca_trust_enabled = false
      enable_host_encryption  = true
      enable_node_public_ip   = false
      eviction_policy         = "Delete"
      orchestrator_version    = var.orchestrator_version
      node_taints = [
        "kubernetes.azure.com/scalesetpriority=spot:NoSchedule",
        "class.truefoundry.io/component=control-plane:NoSchedule"
      ]
      tags           = local.tags
      zones          = []
      vnet_subnet_id = var.subnet_id
      max_pods       = var.max_pods_per_node
  } } : null)

  log_analytics_workspace_name = var.log_analytics_workspace_enable_override ? var.log_analytics_workspace_override_name : "${var.name}-log-analytics"

  log_analytics_cluster_autoscaler_diagnostic_name = var.cluster_autoscaler_diagnostic_enable_override ? var.cluster_autoscaler_diagnostic_override_name : "${var.name}-cluster-autoscaler-diagnostic"
}
