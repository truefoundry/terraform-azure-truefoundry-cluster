# terraform-azure-truefoundry-cluster
Truefoundry Azure Cluster Module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.107.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.107.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | Azure/aks/azurerm | 9.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.network_contributor_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ip_ranges"></a> [allowed\_ip\_ranges](#input\_allowed\_ip\_ranges) | Allowed IP ranges to connect to the cluster | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_control_plane"></a> [control\_plane](#input\_control\_plane) | Whether the cluster is control plane | `bool` | n/a | yes |
| <a name="input_control_plane_instance_type"></a> [control\_plane\_instance\_type](#input\_control\_plane\_instance\_type) | Whether the cluster is control plane | `string` | `"Standard_D2s_v5"` | no |
| <a name="input_cpu_pools"></a> [cpu\_pools](#input\_cpu\_pools) | CPU pools to be attached | <pre>list(object({<br/>    name                  = string<br/>    instance_type         = string<br/>    max_count             = optional(number, 2)<br/>    enable_spot_pool      = optional(bool, true)<br/>    enable_on_demand_pool = optional(bool, true)<br/>  }))</pre> | n/a | yes |
| <a name="input_disk_driver_version"></a> [disk\_driver\_version](#input\_disk\_driver\_version) | Version of disk driver. Supported values `v1` and `v2` | `string` | `"v1"` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size of the initial node pool in GB | `string` | `"100"` | no |
| <a name="input_dns_ip"></a> [dns\_ip](#input\_dns\_ip) | IP from service CIDR used for internal DNS | `string` | `"10.255.0.10"` | no |
| <a name="input_enable_blob_driver"></a> [enable\_blob\_driver](#input\_enable\_blob\_driver) | Enable blob storage provider | `bool` | `true` | no |
| <a name="input_enable_disk_driver"></a> [enable\_disk\_driver](#input\_enable\_disk\_driver) | Enable disk storage provider | `bool` | `true` | no |
| <a name="input_enable_file_driver"></a> [enable\_file\_driver](#input\_enable\_file\_driver) | Enable file storage provider | `bool` | `true` | no |
| <a name="input_enable_snapshot_controller"></a> [enable\_snapshot\_controller](#input\_enable\_snapshot\_controller) | Enable snapshot controller | `bool` | `true` | no |
| <a name="input_enable_storage_profile"></a> [enable\_storage\_profile](#input\_enable\_storage\_profile) | Enable storage profile for the cluster. If disabled `enable_blob_driver`, `enable_file_driver`, `enable_disk_driver` and `enable_snapshot_controller` will have no impact | `bool` | `true` | no |
| <a name="input_gpu_pools"></a> [gpu\_pools](#input\_gpu\_pools) | GPU pools to be attached | <pre>list(object({<br/>    name                  = string<br/>    instance_type         = string<br/>    max_count             = optional(number, 2)<br/>    enable_spot_pool      = optional(bool, true)<br/>    enable_on_demand_pool = optional(bool, true)<br/>  }))</pre> | n/a | yes |
| <a name="input_initial_node_pool_max_count"></a> [initial\_node\_pool\_max\_count](#input\_initial\_node\_pool\_max\_count) | Max count in the initial node pool | `number` | `2` | no |
| <a name="input_initial_node_pool_max_surge"></a> [initial\_node\_pool\_max\_surge](#input\_initial\_node\_pool\_max\_surge) | Max surge in percentage for the intial node pool | `string` | `"10"` | no |
| <a name="input_initial_node_pool_min_count"></a> [initial\_node\_pool\_min\_count](#input\_initial\_node\_pool\_min\_count) | Min count in the initial node pool | `number` | `1` | no |
| <a name="input_initial_node_pool_name"></a> [initial\_node\_pool\_name](#input\_initial\_node\_pool\_name) | Name of the initial node pool | `string` | `"initial"` | no |
| <a name="input_intial_node_pool_instance_type"></a> [intial\_node\_pool\_instance\_type](#input\_intial\_node\_pool\_instance\_type) | Instance size of the initial node pool | `string` | `"Standard_D2s_v5"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of the kubernetes engine | `string` | `"1.30"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the resource group | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_enabled"></a> [log\_analytics\_workspace\_enabled](#input\_log\_analytics\_workspace\_enabled) | value to enable log analytics workspace | `bool` | `true` | no |
| <a name="input_max_pods_per_node"></a> [max\_pods\_per\_node](#input\_max\_pods\_per\_node) | Max pods per node | `number` | `32` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the cluster | `string` | n/a | yes |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Network plugin to use for cluster | `string` | `"kubenet"` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | Enable OIDC for the cluster | `bool` | `true` | no |
| <a name="input_orchestrator_version"></a> [orchestrator\_version](#input\_orchestrator\_version) | Kubernetes version for the orchestration layer (nodes). By default it will be derived with var.kubernetes\_version until passed explicitly | `string` | `"1.30"` | no |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | CIDR of the pod in cluster | `string` | `"10.244.0.0/16"` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | Private cluster | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | CIDR of the services in cluster | `string` | `"10.255.0.0/16"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | SKU tier of the cluster. Defaults to standard | `string` | `"Standard"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet Id for the cluster | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | Vnet ID for the cluster | `string` | n/a | yes |
| <a name="input_workload_identity_enabled"></a> [workload\_identity\_enabled](#input\_workload\_identity\_enabled) | Enable workload identity in the cluster | `bool` | `true` | no |

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