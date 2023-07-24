locals {
  tags = merge(
    {
      "terraform-module" = "network"
      "terraform"        = "true"
      "cluster-name"     = var.name
    },
    var.tags
  )
  intial_node_pool_instance_count = var.control_plane ? 2 : 1
  node_pools = {
    spot = {
      name                = "spotpool"
      node_count          = 1
      max_count           = 20
      min_count           = 1
      os_disk_size_gb     = 100
      priority            = "Spot"
      vm_size             = var.intial_node_pool_spot_instance_type

      # mandatory to pass otherwise node pool will be recreated
      enable_auto_scaling = true
      custom_ca_trust_enabled = false
      enable_host_encryption = false
      enable_node_public_ip = false
      eviction_policy = "Delete"
      node_taints = [
        "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
      ]
      tags = local.tags
      zones = []
      vnet_subnet_id = var.subnet_id
    }
  }
}