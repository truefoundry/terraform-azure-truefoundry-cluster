# terraform-azure-truefoundry-cluster
Truefoundry Azure Cluster Module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.69.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.69.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | Azure/aks/azurerm | 7.2.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.network_contributor_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/3.69.0/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.cluster](https://registry.terraform.io/providers/hashicorp/azurerm/3.69.0/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ip_ranges"></a> [allowed\_ip\_ranges](#input\_allowed\_ip\_ranges) | allowed IP ranges to connect to the cluster | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_control_plane"></a> [control\_plane](#input\_control\_plane) | whether the cluster is control plane | `bool` | n/a | yes |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | disk size of the initial node pool in GB | `string` | `"100"` | no |
| <a name="input_dns_ip"></a> [dns\_ip](#input\_dns\_ip) | IP from service CIDR used for internal DNS | `string` | `"10.0.0.10"` | no |
| <a name="input_intial_node_pool_instance_type"></a> [intial\_node\_pool\_instance\_type](#input\_intial\_node\_pool\_instance\_type) | Instance size of the initial node pool | `string` | `"Standard_D2s_v5"` | no |
| <a name="input_intial_node_pool_spot_instance_type"></a> [intial\_node\_pool\_spot\_instance\_type](#input\_intial\_node\_pool\_spot\_instance\_type) | Instance size of the initial node pool | `string` | `"Standard_D4s_v5"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | version of the kubernetes engine | `string` | `"1.26"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the resource group | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the cluster | `string` | n/a | yes |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | network plugin to use for cluster | `string` | `"kubenet"` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | enable OIDC for the cluster | `bool` | `true` | no |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | CIDR of the pod | `string` | `"10.244.0.0/16"` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | Private cluster | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | service CIDR | `string` | `"10.255.0.0/16"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet Id for the cluster. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | Vnet ID for the cluster | `string` | n/a | yes |
| <a name="input_workload_identity_enabled"></a> [workload\_identity\_enabled](#input\_workload\_identity\_enabled) | enable workload identity in the cluster | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_host"></a> [cluster\_host](#output\_cluster\_host) | The `host` in the `azurerm_kubernetes_cluster`'s `kube_config` block. The Kubernetes cluster server host. |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready |
| <a name="output_cluster_identity"></a> [cluster\_identity](#output\_cluster\_identity) | The `azurerm_kubernetes_cluster`'s `identity` block. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Name of the cluster |
| <a name="output_cluster_networking_profile"></a> [cluster\_networking\_profile](#output\_cluster\_networking\_profile) | Networking profile of the cluster |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | OIDC issuer url of the cluster |
<!-- END_TF_DOCS -->