################################################################################
# Existing cluster
################################################################################

variable "use_existing_cluster" {
  description = "Flag to reuse existing cluster"
  default     = false
  type        = bool
}


variable "name" {
  description = "Name of the cluster. If use_existing_cluster is enabled name is used to fetch details of existing cluster"
  type        = string
}

################################################################################
# Cluster
################################################################################
variable "kubernetes_version" {
  description = "Version of the kubernetes engine"
  default     = "1.33"
  type        = string
}
variable "orchestrator_version" {
  description = "Kubernetes version for the orchestration layer (nodes). By default it will be derived with var.kubernetes_version until passed explicitly"
  type        = string
  default     = "1.33"
}

variable "log_analytics_workspace_enabled" {
  description = "value to enable log analytics workspace"
  type        = bool
  default     = true
}

variable "log_analytics_workspace_enable_override" {
  description = "Enable overriding of the log analytics workspace name."
  type        = bool
  default     = false
}

variable "log_analytics_workspace_override_name" {
  description = "Log analytics workspace name. Default is '<cluster-name>-log-analytics'"
  type        = string
  default     = ""
  validation {
    condition     = can(regex("^([a-zA-Z0-9][a-zA-Z0-9-]{2,61}[a-zA-Z0-9])?$", var.log_analytics_workspace_override_name))
    error_message = "The workspace name must be 4-63 characters long, consisting of letters, digits, or '-', where '-' cannot be the first or last character."
  }
}

variable "cluster_autoscaler_diagnostic_enable_override" {
  description = "Enable overriding of the cluster autoscaler diagnostic setting name."
  type        = bool
  default     = false
}

variable "cluster_autoscaler_diagnostic_override_name" {
  description = "Cluster autoscaler diagnostic setting name. Default is '<cluster-name>-cluster-autoscaler'"
  type        = string
  default     = ""
  validation {
    condition     = can(regex("^([a-zA-Z0-9][a-zA-Z0-9-]{2,61}[a-zA-Z0-9])?$", var.cluster_autoscaler_diagnostic_override_name))
    error_message = "The diagnostic setting name must be 4-63 characters long, consisting of letters, digits, or '-', where '-' cannot be the first or last character."
  }
}

variable "cluster_cost_analysis_enabled" {
  description = "Enable cluster cost analysis"
  type        = bool
  default     = false
}

variable "cluster_monitor_data_collection_rule_enabled" {
  description = "Enable cluster monitor data collection rule"
  type        = bool
  default     = true
}

variable "cluster_data_collection_settings" {
  description = "Cluster data collection settings. `data_collection_interval` - Determines how often the agent collects data. Valid values are 1m - 30m in 1m intervals. Default is 1m. `namespace_filtering_mode_for_data_collection` - Can be 'Include', 'Exclude', or 'Off'. Determines how namespaces are filtered for data collection. `namespaces_for_data_collection` - List of Kubernetes namespaces for data collection based on the filtering mode. `container_log_v2_enabled` - Flag to enable the ContainerLogV2 schema for collecting logs. See more details: https://learn.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-data-collection-configure?tabs=cli#configure-dcr-with-azure-portal-1"
  type = object({
    data_collection_interval                     = string
    namespace_filtering_mode_for_data_collection = string
    namespaces_for_data_collection               = list(string)
    container_log_v2_enabled                     = bool
  })
  default = { "container_log_v2_enabled" : true, "data_collection_interval" : "1m", "namespace_filtering_mode_for_data_collection" : "Off", "namespaces_for_data_collection" : ["kube-system", "gatekeeper-system", "azure-arc"] }
}

variable "cluster_monitor_data_collection_rule_data_sources_syslog_facilities" {
  description = "Syslog supported facilities as documented here: https://learn.microsoft.com/en-us/azure/azure-monitor/agents/data-sources-syslog"
  type        = list(string)
  default     = ["auth", "authpriv", "cron", "daemon", "mark", "kern", "local0", "local1", "local2", "local3", "local4", "local5", "local6", "local7", "lpr", "mail", "news", "syslog", "user", "uucp"]
}

variable "cluster_monitor_data_collection_rule_data_sources_syslog_levels" {
  description = "List of syslog levels"
  type        = list(string)
  default     = ["Debug", "Info", "Notice", "Warning", "Error", "Critical", "Alert", "Emergency"]
}

variable "cluster_monitor_data_collection_rule_extensions_streams" {
  description = "An array of container insights table streams. See documentation in DCR for a list of the valid streams and their corresponding table: https://learn.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-data-collection-configure?tabs=portal#stream-values-in-dcr"
  type        = list(string)
  default     = ["Microsoft-ContainerLog", "Microsoft-ContainerLogV2", "Microsoft-KubeEvents", "Microsoft-KubePodInventory", "Microsoft-KubeNodeInventory", "Microsoft-KubePVInventory", "Microsoft-KubeServices", "Microsoft-KubeMonAgentEvents", "Microsoft-InsightsMetrics", "Microsoft-ContainerInventory", "Microsoft-ContainerNodeInventory", "Microsoft-Perf"]
}

variable "cluster_monitor_metrics" {
  description = "Specifies a Prometheus add-on profile for the Kubernetes Cluster object({ annotations_allowed = '(Optional) Specifies a comma-separated list of Kubernetes annotation keys that will be used in the resource's labels metric.' labels_allowed = '(Optional) Specifies a Comma-separated list of additional Kubernetes label keys that will be used in the resource's labels metric.' })"
  type = object({
    annotations_allowed = optional(string)
    labels_allowed      = optional(string)
  })
  default = null
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

variable "sku_tier" {
  description = "SKU tier of the cluster. Defaults to standard"
  default     = "Standard"
  type        = string
}

variable "rbac_aad" {
  description = "Enable RBAC for the cluster"
  default     = false
  type        = bool
}


variable "rbac_aad_azure_rbac_enabled" {
  description = "Enable Azure RBAC for the cluster"
  default     = false
  type        = bool
}

variable "role_based_access_control_enabled" {
  description = "Enable role based access control for the cluster"
  default     = true
  type        = bool
}


################################################################################
# Initial Nodepool configurations
################################################################################

variable "initial_node_pool_name" {
  description = "Name of the initial node pool"
  default     = "initial"
  type        = string
}

variable "initial_node_pool_instance_type" {
  description = "Instance size of the initial node pool"
  default     = "Standard_D4s_v5"
  type        = string
}

variable "initial_node_pool_max_surge" {
  description = "Max surge in percentage for the intial node pool"
  type        = string
  default     = "10"
}

variable "initial_node_pool_count" {
  description = "Count for the initial node pool. Used only when autoscaling is disabled"
  type        = number
  default     = 2
}

variable "initial_node_pool_max_count" {
  description = "Max count in the initial node pool"
  type        = number
  default     = 2
}

variable "initial_node_pool_min_count" {
  description = "Min count in the initial node pool"
  type        = number
  default     = 1
}

################################################################################
# CPU pool configurations
################################################################################

variable "cpu_pools" {
  description = "CPU pools to be attached"
  type = list(object({
    name                  = string
    instance_type         = string
    min_count             = optional(number, 0)
    max_count             = optional(number, 2)
    enable_spot_pool      = optional(bool, true)
    enable_on_demand_pool = optional(bool, true)
  }))
}


################################################################################
# GPU pool configurations
################################################################################

variable "gpu_pools" {
  description = "GPU pools to be attached"
  type = list(object({
    name                  = string
    instance_type         = string
    min_count             = optional(number, 0)
    max_count             = optional(number, 2)
    enable_spot_pool      = optional(bool, true)
    enable_on_demand_pool = optional(bool, true)
  }))
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

variable "control_plane_instance_type" {
  description = "Control plane nodepool instance type"
  default     = "Standard_D4s_v5"
  type        = string
}

variable "critical_node_pool_enabled" {
  description = "Enable Critical nodepool for the cluster"
  default     = true
  type        = bool
}

variable "critical_node_pool_instance_type" {
  description = "Critical nodepool instance type"
  default     = "Standard_D4s_v5"
  type        = string

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

variable "max_pods_per_node" {
  description = "Max pods per node"
  type        = number
  default     = 32
}

################################################################################
# Autoscaling configurations
################################################################################

variable "enable_auto_scaling" {
  description = "Enable auto scaling for the cluster"
  type        = bool
  default     = true
}

variable "enable_autoscaler_profile" {
  description = "Enable autoscaler profile for the cluster"
  type        = bool
  default     = true
}

variable "autoscaler_profile_expander" {
  description = "Expander for the autoscaler profile. Possible values are `least-waste`, `priority`, `most-pods` and `random`. Defaults to `least-waste`"
  type        = string
  default     = "least-waste"
}

variable "autoscaler_profile_max_graceful_termination_sec" {
  description = "Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to 180"
  type        = number
  default     = 180
}

variable "autoscaler_profile_max_node_provisioning_time" {
  description = "Maximum time the autoscaler waits for a node to be provisioned. Defaults to 15 minutes"
  type        = string
  default     = "15m"
}

variable "autoscaler_profile_max_unready_nodes" {
  description = "Maximum Number of allowed unready nodes. Defaults to 3"
  type        = number
  default     = 3
}

variable "autoscaler_profile_scale_down_delay_after_add" {
  description = "Scale down delay after add for the autoscaler profile"
  type        = string
  default     = "2m"
}

variable "autoscaler_profile_scale_down_delay_after_delete" {
  description = "Scale down delay after delete for the autoscaler profile"
  type        = string
  default     = "30s"
}

variable "autoscaler_profile_scale_down_unneeded" {
  description = "Scale down unneeded for the autoscaler profile"
  type        = string
  default     = "1m"
}

variable "autoscaler_profile_scale_down_unready" {
  description = "Scale down unready for the autoscaler profile"
  type        = string
  default     = "2m"
}

variable "autoscaler_profile_scale_down_utilization_threshold" {
  description = "Scale down utilization threshold for the autoscaler profile"
  type        = number
  default     = 0.7
}

variable "autoscaler_profile_skip_nodes_with_system_pods" {
  description = "Skip nodes with system pods for the autoscaler profile"
  type        = bool
  default     = true
}

variable "autoscaler_profile_skip_nodes_with_local_storage" {
  description = "Skip nodes with pods with local storage, for example, EmptyDir or HostPath"
  type        = bool
  default     = false
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
  default     = "azure"
}

variable "network_plugin_mode" {
  description = "Network plugin mode to use for cluster"
  type        = string
  default     = "overlay"
}

variable "network_data_plane" {
  description = "Network data plane to use for cluster.Possible values are `azure` and `cilium`"
  type        = string
  default     = "azure"
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
