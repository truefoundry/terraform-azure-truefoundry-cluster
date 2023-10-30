################################################################################
# Cluster
################################################################################

variable "name" {
  description = "Name of the cluster"
  type        = string
}
variable "kubernetes_version" {
  description = "Version of the kubernetes engine"
  default     = "1.27"
  type        = string
}

variable "oidc_issuer_enabled" {
  description = "Enable OIDC for the cluster"
  default     = true
  type        = bool
}

variable "disk_size" {
  description = "Disk size of the initial node pool in GB"
  default     = "100"
  type        = string
}

variable "intial_node_pool_instance_type" {
  description = "Instance size of the initial node pool"
  default     = "Standard_D2s_v5"
  type        = string
}

variable "intial_node_pool_spot_instance_type" {
  description = "Instance size of the initial node pool"
  default     = "Standard_D4s_v5"
  type        = string
}

variable "workload_identity_enabled" {
  description = "Enable workload identity in the cluster"
  default     = true
  type        = bool
}

variable "control_plane" {
  description = "Whether the cluster is control plane"
  type        = bool

}

variable "enable_storage_profile" {
  description = "Enable storage profile for the cluster. If disabled `enable_blob_driver`, `enable_file_driver`, `enable_disk_driver` and `enable_snapshot_controller` will have no impact"
  type        = bool
  default     = true
}

variable "enable_blob_driver" {
  description = "Enable blob storage provider"
  type        = bool
  default     = true
}

variable "enable_file_driver" {
  description = "Enable file storage provider"
  type        = bool
  default     = true
}

variable "enable_disk_driver" {
  description = "Enable disk storage provider"
  type        = bool
  default     = true
}

variable "disk_driver_version" {
  description = "Version of disk driver. Supported values `v1` and `v2`"
  type        = string
  default     = "v1"
}
variable "enable_snapshot_controller" {
  description = "Enable snapshot controller"
  type        = bool
  default     = true
}
################################################################################
# Network
################################################################################

variable "vnet_id" {
  description = "Vnet ID for the cluster"
  type        = string
}

variable "subnet_id" {
  description = "Subnet Id for the cluster"
  type        = string
}

variable "network_plugin" {
  description = "Network plugin to use for cluster"
  type        = string
  default     = "kubenet"
}

variable "pod_cidr" {
  description = "CIDR of the pod in cluster"
  default     = "10.244.0.0/16"
  type        = string
}

variable "service_cidr" {
  description = "CIDR of the services in cluster"
  default     = "10.255.0.0/16"
  type        = string
}

variable "dns_ip" {
  description = "IP from service CIDR used for internal DNS"
  default     = "10.255.0.10"
  type        = string
}

variable "allowed_ip_ranges" {
  description = "Allowed IP ranges to connect to the cluster"
  default     = ["0.0.0.0/0"]
  type        = list(string)
}

variable "private_cluster_enabled" {
  description = "Private cluster"
  default     = false
  type        = bool
}

################################################################################
# Generic
################################################################################

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resource group"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
