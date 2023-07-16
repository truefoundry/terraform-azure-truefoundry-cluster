locals {
  tags = merge(
    {
      "terraform-module" = "network"
      "terraform"        = "true"
      "cluster-name"     = var.name
    },
    var.tags
  )
  node_pools = {
    spot = {
      name                = "spotpool"
      node_count          = 1
      max_count           = 20
      min_count           = 1
      os_disk_size_gb     = 100
      priority            = "Spot"
      vm_size             = var.intial_node_pool_spot_instance_type
      enable_auto_scaling = true

    }
  }
}