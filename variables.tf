################################################################################
# Cluster
################################################################################

variable "name" {
  description = "Name of the cluster"
  type        = string
}

variable "private_cluster_enabled" {
  description = "Private cluster"
  default     = false
  type        = bool
}


################################################################################
# Network
################################################################################

variable "vnet_id" {
  description = "Vnet ID for the cluster"
}
variable "subnet_id" {
  description = "Subnet Id for the cluster."
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
