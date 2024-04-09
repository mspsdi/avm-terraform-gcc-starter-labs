# Lab 4 - Create Solution Accelerator Azure Key Vault
## Step 1
### Navigate to the solution accelerators project directory: 
#### /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project.

```bash
cd /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project
```

## Step 2
### Duplicate the folder named "solution_accelerators_template" and rename the duplicate as "lab".

## Step 3
### In the file resource_groups.tf, locate line 2 and replace "yourresourcegroup" with "lab".

## Step 4
### Configure Key Vault terraform module

### 4.1
#### Insert the following lines into the "main.tf" file:

```bash
module "keyvault1" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.5.2"  

  name                          = "${module.naming.key_vault.name_unique}${random_string.this.result}" 
  enable_telemetry              = var.enable_telemetry
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name
  # add your keyvault configuration below

}
```

### 4.2
#### After line 9 of the module above, include the following Key Vault configurations:

```bash
  tenant_id           = data.azurerm_client_config.current.tenant_id
  network_acls = {
    default_action = "Allow"
  }

  role_assignments = {
    deployment_user_secrets = {
      role_definition_id_or_name = "Key Vault Secrets Officer"
      principal_id               = data.azurerm_client_config.current.object_id
    }
  }

  wait_for_rbac_before_secret_operations = {
    create = "60s"
  }
```

## Step 5
### Navigate to the directory: 
#### /tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/keyvault

```bash
cd /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project/lab
```

## Step 6
### Execute Terraform commands to initialize, plan, and apply configurations:

### Initialize Terraform with backend configuration
```bash
terraform init  -reconfigure \
-backend-config="resource_group_name={{resource group name}}" \
-backend-config="storage_account_name={{storage account name}}" \
-backend-config="container_name=2-solution-accelerators" \
-backend-config="key=solution_accelerators-project-lab.tfstate"
```
#### Note: Ensure the key above is rename to "solution_accelerators-project-keyvault.tfstate"

### Generate and preview an execution plan
```bash
terraform plan \
-var="resource_group_name={{resource group name}}" \
-var="storage_account_name={{storage account name}}" 
```

### Apply the Terraform configurations
```bash
terraform apply -auto-approve \
-var="resource_group_name={{resource group name}}" \
-var="storage_account_name={{storage account name}}" 
```

### Note: Please replace {{resource group name}} and {{storage account name}} with the actual names of the resource group and storage account created during Lab1.

## Step 7
### Verify your Azure resources in Azure portal

