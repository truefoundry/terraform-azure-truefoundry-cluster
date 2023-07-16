################################################################################
# Cluster
################################################################################

variable "name" {
  description = "Name of the cluster"
  type        = string
}
variable "kubernetes_version" {
  description = "version of the kubernetes engine"
  default     = "1.26"
  type        = string
}

variable "oidc_issuer_enabled" {
  description = "enable OIDC for the cluster"
  default     = true
  type        = bool
}

variable "disk_size" {
  description = "disk size of the initial node pool in GB"
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
  default     = "Standard_D2s_v5"
  type        = string
}

variable "workload_identity_enabled" {
  description = "enable workload identity in the cluster"
  default     = true
  type        = bool
}
################################################################################
# Network
################################################################################

variable "vnet_id" {
  description = "Vnet ID for the cluster"
  type        = string
}

variable "subnet_id" {
  description = "Subnet Id for the cluster."
  type        = string
}

variable "network_plugin" {
  description = "network plugin to use for cluster"
  type        = string
  default     = "kubenet"
}

variable "pod_cidr" {
  description = "CIDR of the pod"
  default     = "10.244.0.0/16"
  type        = string
}

variable "server_cidr" {
  description = "service CIDR"
  default     = "10.0.0.0/16"
  type        = string
}

variable "dns_ip" {
  description = "IP from service CIDR used for internal DNS"
  default     = "10.0.0.10"
  type        = string
}

variable "allowed_ip_ranges" {
  description = "allowed IP ranges to connect to the cluster"
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
