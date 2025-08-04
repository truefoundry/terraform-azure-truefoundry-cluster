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
| <a name="module_aks"></a> [aks](#module\_aks) | Azure/aks/azurerm | 10.2.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.cluster_autoscaler_diagnostic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_role_assignment.network_contributor_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_kubernetes_cluster.cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ip_ranges"></a> [allowed\_ip\_ranges](#input\_allowed\_ip\_ranges) | Allowed IP ranges to connect to the cluster | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_autoscaler_profile_expander"></a> [autoscaler\_profile\_expander](#input\_autoscaler\_profile\_expander) | Expander for the autoscaler profile. Possible values are `least-waste`, `priority`, `most-pods` and `random`. Defaults to `least-waste` | `string` | `"least-waste"` | no |
| <a name="input_autoscaler_profile_max_graceful_termination_sec"></a> [autoscaler\_profile\_max\_graceful\_termination\_sec](#input\_autoscaler\_profile\_max\_graceful\_termination\_sec) | Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to 180 | `number` | `180` | no |
| <a name="input_autoscaler_profile_max_node_provisioning_time"></a> [autoscaler\_profile\_max\_node\_provisioning\_time](#input\_autoscaler\_profile\_max\_node\_provisioning\_time) | Maximum time the autoscaler waits for a node to be provisioned. Defaults to 15 minutes | `string` | `"15m"` | no |
| <a name="input_autoscaler_profile_max_unready_nodes"></a> [autoscaler\_profile\_max\_unready\_nodes](#input\_autoscaler\_profile\_max\_unready\_nodes) | Maximum Number of allowed unready nodes. Defaults to 3 | `number` | `3` | no |
| <a name="input_autoscaler_profile_scale_down_delay_after_add"></a> [autoscaler\_profile\_scale\_down\_delay\_after\_add](#input\_autoscaler\_profile\_scale\_down\_delay\_after\_add) | Scale down delay after add for the autoscaler profile | `string` | `"2m"` | no |
| <a name="input_autoscaler_profile_scale_down_delay_after_delete"></a> [autoscaler\_profile\_scale\_down\_delay\_after\_delete](#input\_autoscaler\_profile\_scale\_down\_delay\_after\_delete) | Scale down delay after delete for the autoscaler profile | `string` | `"30s"` | no |
| <a name="input_autoscaler_profile_scale_down_unneeded"></a> [autoscaler\_profile\_scale\_down\_unneeded](#input\_autoscaler\_profile\_scale\_down\_unneeded) | Scale down unneeded for the autoscaler profile | `string` | `"1m"` | no |
| <a name="input_autoscaler_profile_scale_down_unready"></a> [autoscaler\_profile\_scale\_down\_unready](#input\_autoscaler\_profile\_scale\_down\_unready) | Scale down unready for the autoscaler profile | `string` | `"2m"` | no |
| <a name="input_autoscaler_profile_scale_down_utilization_threshold"></a> [autoscaler\_profile\_scale\_down\_utilization\_threshold](#input\_autoscaler\_profile\_scale\_down\_utilization\_threshold) | Scale down utilization threshold for the autoscaler profile | `number` | `0.7` | no |
| <a name="input_autoscaler_profile_skip_nodes_with_local_storage"></a> [autoscaler\_profile\_skip\_nodes\_with\_local\_storage](#input\_autoscaler\_profile\_skip\_nodes\_with\_local\_storage) | Skip nodes with pods with local storage, for example, EmptyDir or HostPath | `bool` | `false` | no |
| <a name="input_autoscaler_profile_skip_nodes_with_system_pods"></a> [autoscaler\_profile\_skip\_nodes\_with\_system\_pods](#input\_autoscaler\_profile\_skip\_nodes\_with\_system\_pods) | Skip nodes with system pods for the autoscaler profile | `bool` | `true` | no |
| <a name="input_cluster_autoscaler_diagnostic_enable_override"></a> [cluster\_autoscaler\_diagnostic\_enable\_override](#input\_cluster\_autoscaler\_diagnostic\_enable\_override) | Enable overriding of the cluster autoscaler diagnostic setting name. | `bool` | `false` | no |
| <a name="input_cluster_autoscaler_diagnostic_override_name"></a> [cluster\_autoscaler\_diagnostic\_override\_name](#input\_cluster\_autoscaler\_diagnostic\_override\_name) | Cluster autoscaler diagnostic setting name. Default is '<cluster-name>-cluster-autoscaler' | `string` | `""` | no |
| <a name="input_cluster_cost_analysis_enabled"></a> [cluster\_cost\_analysis\_enabled](#input\_cluster\_cost\_analysis\_enabled) | Enable cluster cost analysis | `bool` | `false` | no |
| <a name="input_cluster_data_collection_settings"></a> [cluster\_data\_collection\_settings](#input\_cluster\_data\_collection\_settings) | Cluster data collection settings. `data_collection_interval` - Determines how often the agent collects data. Valid values are 1m - 30m in 1m intervals. Default is 1m. `namespace_filtering_mode_for_data_collection` - Can be 'Include', 'Exclude', or 'Off'. Determines how namespaces are filtered for data collection. `namespaces_for_data_collection` - List of Kubernetes namespaces for data collection based on the filtering mode. `container_log_v2_enabled` - Flag to enable the ContainerLogV2 schema for collecting logs. See more details: https://learn.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-data-collection-configure?tabs=cli#configure-dcr-with-azure-portal-1 | <pre>object({<br/>    data_collection_interval                     = string<br/>    namespace_filtering_mode_for_data_collection = string<br/>    namespaces_for_data_collection               = list(string)<br/>    container_log_v2_enabled                     = bool<br/>  })</pre> | <pre>{<br/>  "container_log_v2_enabled": true,<br/>  "data_collection_interval": "1m",<br/>  "namespace_filtering_mode_for_data_collection": "Off",<br/>  "namespaces_for_data_collection": [<br/>    "kube-system",<br/>    "gatekeeper-system",<br/>    "azure-arc"<br/>  ]<br/>}</pre> | no |
| <a name="input_cluster_monitor_data_collection_rule_data_sources_syslog_facilities"></a> [cluster\_monitor\_data\_collection\_rule\_data\_sources\_syslog\_facilities](#input\_cluster\_monitor\_data\_collection\_rule\_data\_sources\_syslog\_facilities) | Syslog supported facilities as documented here: https://learn.microsoft.com/en-us/azure/azure-monitor/agents/data-sources-syslog | `list(string)` | <pre>[<br/>  "auth",<br/>  "authpriv",<br/>  "cron",<br/>  "daemon",<br/>  "mark",<br/>  "kern",<br/>  "local0",<br/>  "local1",<br/>  "local2",<br/>  "local3",<br/>  "local4",<br/>  "local5",<br/>  "local6",<br/>  "local7",<br/>  "lpr",<br/>  "mail",<br/>  "news",<br/>  "syslog",<br/>  "user",<br/>  "uucp"<br/>]</pre> | no |
| <a name="input_cluster_monitor_data_collection_rule_data_sources_syslog_levels"></a> [cluster\_monitor\_data\_collection\_rule\_data\_sources\_syslog\_levels](#input\_cluster\_monitor\_data\_collection\_rule\_data\_sources\_syslog\_levels) | List of syslog levels | `list(string)` | <pre>[<br/>  "Debug",<br/>  "Info",<br/>  "Notice",<br/>  "Warning",<br/>  "Error",<br/>  "Critical",<br/>  "Alert",<br/>  "Emergency"<br/>]</pre> | no |
| <a name="input_cluster_monitor_data_collection_rule_enabled"></a> [cluster\_monitor\_data\_collection\_rule\_enabled](#input\_cluster\_monitor\_data\_collection\_rule\_enabled) | Enable cluster monitor data collection rule | `bool` | `true` | no |
| <a name="input_cluster_monitor_data_collection_rule_extensions_streams"></a> [cluster\_monitor\_data\_collection\_rule\_extensions\_streams](#input\_cluster\_monitor\_data\_collection\_rule\_extensions\_streams) | An array of container insights table streams. See documentation in DCR for a list of the valid streams and their corresponding table: https://learn.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-data-collection-configure?tabs=portal#stream-values-in-dcr | `list(string)` | <pre>[<br/>  "Microsoft-ContainerLog",<br/>  "Microsoft-ContainerLogV2",<br/>  "Microsoft-KubeEvents",<br/>  "Microsoft-KubePodInventory",<br/>  "Microsoft-KubeNodeInventory",<br/>  "Microsoft-KubePVInventory",<br/>  "Microsoft-KubeServices",<br/>  "Microsoft-KubeMonAgentEvents",<br/>  "Microsoft-InsightsMetrics",<br/>  "Microsoft-ContainerInventory",<br/>  "Microsoft-ContainerNodeInventory",<br/>  "Microsoft-Perf"<br/>]</pre> | no |
| <a name="input_cluster_monitor_metrics"></a> [cluster\_monitor\_metrics](#input\_cluster\_monitor\_metrics) | Specifies a Prometheus add-on profile for the Kubernetes Cluster object({ annotations\_allowed = '(Optional) Specifies a comma-separated list of Kubernetes annotation keys that will be used in the resource's labels metric.' labels\_allowed = '(Optional) Specifies a Comma-separated list of additional Kubernetes label keys that will be used in the resource's labels metric.' }) | <pre>object({<br/>    annotations_allowed = optional(string)<br/>    labels_allowed      = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_control_plane"></a> [control\_plane](#input\_control\_plane) | Whether the cluster is control plane | `bool` | n/a | yes |
| <a name="input_control_plane_instance_type"></a> [control\_plane\_instance\_type](#input\_control\_plane\_instance\_type) | Control plane nodepool instance type | `string` | `"Standard_D4s_v5"` | no |
| <a name="input_cpu_pools"></a> [cpu\_pools](#input\_cpu\_pools) | CPU pools to be attached | <pre>list(object({<br/>    name                  = string<br/>    instance_type         = string<br/>    min_count             = optional(number, 0)<br/>    max_count             = optional(number, 2)<br/>    enable_spot_pool      = optional(bool, true)<br/>    enable_on_demand_pool = optional(bool, true)<br/>  }))</pre> | n/a | yes |
| <a name="input_critical_node_pool_enabled"></a> [critical\_node\_pool\_enabled](#input\_critical\_node\_pool\_enabled) | Enable Critical nodepool for the cluster | `bool` | `true` | no |
| <a name="input_critical_node_pool_instance_type"></a> [critical\_node\_pool\_instance\_type](#input\_critical\_node\_pool\_instance\_type) | Critical nodepool instance type | `string` | `"Standard_D4s_v5"` | no |
| <a name="input_disk_driver_version"></a> [disk\_driver\_version](#input\_disk\_driver\_version) | Version of disk driver. Supported values `v1` and `v2` | `string` | `"v1"` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Disk size of the initial node pool in GB | `string` | `"100"` | no |
| <a name="input_dns_ip"></a> [dns\_ip](#input\_dns\_ip) | IP from service CIDR used for internal DNS | `string` | `"10.255.0.10"` | no |
| <a name="input_enable_auto_scaling"></a> [enable\_auto\_scaling](#input\_enable\_auto\_scaling) | Enable auto scaling for the cluster | `bool` | `true` | no |
| <a name="input_enable_autoscaler_profile"></a> [enable\_autoscaler\_profile](#input\_enable\_autoscaler\_profile) | Enable autoscaler profile for the cluster | `bool` | `true` | no |
| <a name="input_enable_blob_driver"></a> [enable\_blob\_driver](#input\_enable\_blob\_driver) | Enable blob storage provider | `bool` | `true` | no |
| <a name="input_enable_disk_driver"></a> [enable\_disk\_driver](#input\_enable\_disk\_driver) | Enable disk storage provider | `bool` | `true` | no |
| <a name="input_enable_file_driver"></a> [enable\_file\_driver](#input\_enable\_file\_driver) | Enable file storage provider | `bool` | `true` | no |
| <a name="input_enable_snapshot_controller"></a> [enable\_snapshot\_controller](#input\_enable\_snapshot\_controller) | Enable snapshot controller | `bool` | `true` | no |
| <a name="input_enable_storage_profile"></a> [enable\_storage\_profile](#input\_enable\_storage\_profile) | Enable storage profile for the cluster. If disabled `enable_blob_driver`, `enable_file_driver`, `enable_disk_driver` and `enable_snapshot_controller` will have no impact | `bool` | `true` | no |
| <a name="input_gpu_pools"></a> [gpu\_pools](#input\_gpu\_pools) | GPU pools to be attached | <pre>list(object({<br/>    name                  = string<br/>    instance_type         = string<br/>    min_count             = optional(number, 0)<br/>    max_count             = optional(number, 2)<br/>    enable_spot_pool      = optional(bool, true)<br/>    enable_on_demand_pool = optional(bool, true)<br/>  }))</pre> | n/a | yes |
| <a name="input_initial_node_pool_count"></a> [initial\_node\_pool\_count](#input\_initial\_node\_pool\_count) | Count for the initial node pool. Used only when autoscaling is disabled | `number` | `2` | no |
| <a name="input_initial_node_pool_instance_type"></a> [initial\_node\_pool\_instance\_type](#input\_initial\_node\_pool\_instance\_type) | Instance size of the initial node pool | `string` | `"Standard_D4s_v5"` | no |
| <a name="input_initial_node_pool_max_count"></a> [initial\_node\_pool\_max\_count](#input\_initial\_node\_pool\_max\_count) | Max count in the initial node pool | `number` | `2` | no |
| <a name="input_initial_node_pool_max_surge"></a> [initial\_node\_pool\_max\_surge](#input\_initial\_node\_pool\_max\_surge) | Max surge in percentage for the intial node pool | `string` | `"10"` | no |
| <a name="input_initial_node_pool_min_count"></a> [initial\_node\_pool\_min\_count](#input\_initial\_node\_pool\_min\_count) | Min count in the initial node pool | `number` | `1` | no |
| <a name="input_initial_node_pool_name"></a> [initial\_node\_pool\_name](#input\_initial\_node\_pool\_name) | Name of the initial node pool | `string` | `"initial"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of the kubernetes engine | `string` | `"1.32"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the resource group | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_enable_override"></a> [log\_analytics\_workspace\_enable\_override](#input\_log\_analytics\_workspace\_enable\_override) | Enable overriding of the log analytics workspace name. | `bool` | `false` | no |
| <a name="input_log_analytics_workspace_enabled"></a> [log\_analytics\_workspace\_enabled](#input\_log\_analytics\_workspace\_enabled) | value to enable log analytics workspace | `bool` | `true` | no |
| <a name="input_log_analytics_workspace_override_name"></a> [log\_analytics\_workspace\_override\_name](#input\_log\_analytics\_workspace\_override\_name) | Log analytics workspace name. Default is '<cluster-name>-log-analytics' | `string` | `""` | no |
| <a name="input_max_pods_per_node"></a> [max\_pods\_per\_node](#input\_max\_pods\_per\_node) | Max pods per node | `number` | `32` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the cluster. If use\_existing\_cluster is enabled name is used to fetch details of existing cluster | `string` | n/a | yes |
| <a name="input_network_data_plane"></a> [network\_data\_plane](#input\_network\_data\_plane) | Network data plane to use for cluster.Possible values are `azure` and `cilium` | `string` | `"azure"` | no |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Network plugin to use for cluster | `string` | `"azure"` | no |
| <a name="input_network_plugin_mode"></a> [network\_plugin\_mode](#input\_network\_plugin\_mode) | Network plugin mode to use for cluster | `string` | `"overlay"` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | Enable OIDC for the cluster | `bool` | `true` | no |
| <a name="input_orchestrator_version"></a> [orchestrator\_version](#input\_orchestrator\_version) | Kubernetes version for the orchestration layer (nodes). By default it will be derived with var.kubernetes\_version until passed explicitly | `string` | `"1.32"` | no |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | CIDR of the pod in cluster | `string` | `"10.244.0.0/16"` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | Private cluster | `bool` | `false` | no |
| <a name="input_rbac_aad"></a> [rbac\_aad](#input\_rbac\_aad) | Enable RBAC for the cluster | `bool` | `false` | no |
| <a name="input_rbac_aad_azure_rbac_enabled"></a> [rbac\_aad\_azure\_rbac\_enabled](#input\_rbac\_aad\_azure\_rbac\_enabled) | Enable Azure RBAC for the cluster | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled) | Enable role based access control for the cluster | `bool` | `true` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | CIDR of the services in cluster | `string` | `"10.255.0.0/16"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | SKU tier of the cluster. Defaults to standard | `string` | `"Standard"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet Id for the cluster | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_use_existing_cluster"></a> [use\_existing\_cluster](#input\_use\_existing\_cluster) | Flag to reuse existing cluster | `bool` | `false` | no |
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
| <a name="output_use_existing_cluster"></a> [use\_existing\_cluster](#output\_use\_existing\_cluster) | Flag to check if an existing cluster is used |
<!-- END_TF_DOCS -->