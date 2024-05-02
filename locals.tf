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
  intial_node_pool_min_count = var.control_plane ? 2 : 1
  intial_node_pool_max_count = var.control_plane ? 3 : 2
  cpupools = [
    {
      "name"    = "cpu"
      "vm_size" = "Standard_D4ds_v5"
    },
    {
      "name"    = "cpu2x"
      "vm_size" = "Standard_D8ds_v5"
    }
  ]
  gpupools = [
    var.enable_A100_node_pools ? {
      name    = "a100"
      vm_size = "Standard_NC24ads_A100_v4"
    } : null,
    var.enable_A100_node_pools ? {
      name    = "a100x2"
      vm_size = "Standard_NC48ads_A100_v4"
    } : null,
    var.enable_A100_node_pools ? {
      name    = "a100x4"
      vm_size = "Standard_NC96ads_A100_v4"
    } : null,
    var.enable_A10_node_pools ? {
      name    = "a10"
      vm_size = "Standard_NV6ads_A10_v5"
    } : null,
    var.enable_A10_node_pools ? {
      name    = "a10x2"
      vm_size = "Standard_NV12ads_A10_v5"
    } : null,
    var.enable_A10_node_pools ? {
      name    = "a10x3"
      vm_size = "Standard_NV18ads_A10_v5"
    } : null,
    var.enable_A10_node_pools ? {
      name    = "a10x6"
      vm_size = "Standard_NV36ads_A10_v5"
    } : null,
    var.enable_T4_node_pools ? {
      name    = "t4"
      vm_size = "Standard_NC4as_T4_v3"
    } : null,
    var.enable_T4_node_pools ? {
      name    = "t4x2"
      vm_size = "Standard_NC8as_T4_v3"
    } : null,
    var.enable_T4_node_pools ? {
      name    = "t4x4"
      vm_size = "Standard_NC16as_T4_v3"
    } : null,
    var.enable_T4_node_pools ? {
      name    = "t4x16"
      vm_size = "Standard_NC64as_T4_v3"
    } : null
  ]
  node_pools = merge({ for k, v in local.cpupools : "${v["name"]}sp" => {
    name                    = "${v["name"]}sp"
    node_count              = 0
    max_count               = 10
    min_count               = 0
    os_disk_size_gb         = 100
    priority                = "Spot"
    vm_size                 = v["vm_size"]
    enable_auto_scaling     = true
    custom_ca_trust_enabled = false
    enable_host_encryption  = true
    enable_node_public_ip   = false
    eviction_policy         = "Delete"
    orchestrator_version    = var.kubernetes_version
    node_taints = [
      "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
    ]
    tags           = local.tags
    zones          = []
    vnet_subnet_id = var.subnet_id
    max_pods       = var.max_pods_per_node
    } },
    { for k, v in local.gpupools : "${v["name"]}sp" => {
      name                    = "${v["name"]}sp"
      node_count              = 0
      max_count               = 5
      min_count               = 0
      os_disk_size_gb         = 100
      priority                = "Spot"
      vm_size                 = v["vm_size"]
      enable_auto_scaling     = true
      custom_ca_trust_enabled = false
      enable_host_encryption  = true
      enable_node_public_ip   = false
      eviction_policy         = "Delete"
      orchestrator_version    = var.kubernetes_version
      node_taints = [
        "kubernetes.azure.com/scalesetpriority=spot:NoSchedule",
        "nvidia.com/gpu=Present:NoSchedule"
      ]
      tags           = local.tags
      zones          = []
      vnet_subnet_id = var.subnet_id
      max_pods       = var.max_pods_per_node
    } if v != null },
    { for k, v in local.gpupools : "${v["name"]}" => {
      name                    = "${v["name"]}"
      node_count              = 0
      max_count               = 5
      min_count               = 0
      os_disk_size_gb         = 100
      priority                = "Regular"
      vm_size                 = v["vm_size"]
      enable_auto_scaling     = true
      custom_ca_trust_enabled = false
      enable_host_encryption  = true
      enable_node_public_ip   = false
      orchestrator_version    = var.kubernetes_version
      node_taints = [
        "nvidia.com/gpu=Present:NoSchedule"
      ]
      tags           = local.tags
      zones          = []
      vnet_subnet_id = var.subnet_id
      max_pods       = var.max_pods_per_node
  } if v != null })
}
