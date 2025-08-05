# terraform-azure-truefoundry-cluster
This guide will help you to migrate your terraform code across versions. Keeping your terraform state to the latest version is always recommeneded

## Upgrade guide from 0.6.x to 0.7.x
1. Ensure that you are running on the latest version of 0.6.x
2. Add the following variable
```hcl
role_based_access_control_enabled = false
network_plugin = "kubenet"
network_plugin_mode = null
cluster_monitor_data_collection_rule_enabled = false
```
3. Move to `0.7.0` and run the following commands
    ```bash
    terraform init -upgrade
    terraform apply
    ```
4. Once done you can also move to cluster version 1.32 by removing the variable `kubernetes_version` and `orchestrator_version` if passed from outside.
   

## Upgrade guide from 0.5.x to 0.6.x
1. Ensure that you are running on the latest version of 0.5.x
2. Move to `0.6.0` and run the following command
    ```bash
    terraform init -upgrade
    ```
3. Run the migration script present in the `scripts/` directory
    ```bash
    bash migration-script-6.sh
    ```
4. Run terraform plan to check if there are is diff
    ```bash
    terraform plan
    ```