# terraform-azure-truefoundry-cluster
This guide will help you to migrate your terraform code across versions. Keeping your terraform state to the latest version is always recommeneded

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