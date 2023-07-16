# From https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/outputs.tf

################################################################################
# Cluster
################################################################################

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.aks.cluster_fqdn
}

output "cluster_id" {
  description = "The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready"
  value       = module.aks.aks_id
}

output "cluster_name" {
  description = "Name of the cluster"
  value       = module.aks.aks_name
}

output "cluster_identity" {
  description = "The `azurerm_kubernetes_cluster`'s `identity` block."
  value = module.aks.cluster_identity
}

output "cluster_host" {
  description = "The `host` in the `azurerm_kubernetes_cluster`'s `kube_config` block. The Kubernetes cluster server host."
  value = module.aks.host
  sensitive = true
}

output "cluster_networking_profile" {
  description = "Networking profile of the cluster"
  value = module.aks.network_profile
}

output "cluster_oidc_issuer_url" {
  description = "OIDC issuer url of the cluster"
  value = module.aks.oidc_issuer_url
}