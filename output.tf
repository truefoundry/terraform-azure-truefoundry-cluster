# From https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/outputs.tf

################################################################################
# Cluster
################################################################################
output "use_existing_cluster" {
  description = "Flag to check if an existing cluster is used"
  value       = var.use_existing_cluster
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = var.use_existing_cluster ? trimsuffix(data.azurerm_kubernetes_cluster.cluster[0].kube_config[0].host, ":443") : module.aks[0].cluster_fqdn
}

output "cluster_id" {
  description = "The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready"
  value       = var.use_existing_cluster ? data.azurerm_kubernetes_cluster.cluster[0].id : module.aks[0].aks_id
}

output "cluster_name" {
  description = "Name of the cluster"
  value       = var.use_existing_cluster ? var.name : module.aks[0].aks_name
}

output "cluster_identity" {
  description = "The `azurerm_kubernetes_cluster`'s `identity` block."
  value       = var.use_existing_cluster ? data.azurerm_kubernetes_cluster.cluster[0].identity : module.aks[0].cluster_identity
}

output "cluster_host" {
  description = "The `host` in the `azurerm_kubernetes_cluster`'s `kube_config` block. The Kubernetes cluster server host."
  value       = var.use_existing_cluster ? data.azurerm_kubernetes_cluster.cluster[0].kube_config[0].host : module.aks[0].host
  sensitive   = true # its needed because the upstream marks it sensitive
}

output "cluster_networking_profile" {
  description = "Networking profile of the cluster"
  value       = var.use_existing_cluster ? data.azurerm_kubernetes_cluster.cluster[0].network_profile : module.aks[0].network_profile
}

output "cluster_oidc_issuer_url" {
  description = "OIDC issuer url of the cluster"
  value       = var.use_existing_cluster ? data.azurerm_kubernetes_cluster.cluster[0].oidc_issuer_url : module.aks[0].oidc_issuer_url
}