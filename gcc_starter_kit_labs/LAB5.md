# Lab 5 - Create Solution Accelerator Azure Key Vault
## Step 1
### Navigate to the solution accelerators project directory: 
#### /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project.

```bash
cd /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project
```

## Step 2
### Duplicate the folder named "solution_accelerators_template" and rename the duplicate as "keyvault".

```bash
cp /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project/solution_accelerators_template /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project/keyvault
```

## Step 3
### In the file resource_groups.tf, locate line 2 and replace "yourresourcegroup" with “keyvault".

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
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled      = false 
  soft_delete_retention_days    = 7 
  public_network_access_enabled = false
  private_endpoints = {
    primary = {
      private_dns_zone_resource_ids = [module.private_dns_zones.private_dnz_zone_output.id] 
      subnet_resource_id            = local.remote.networking.virtual_networks.spoke_project.virtual_subnets.subnets["ServiceSubnet"].id  
    }
  }
  tags = { 
    purpose = "key vault" 
    project_code = local.global_settings.prefix 
    env = local.global_settings.environment 
    zone = "project"
    tier = "service"           
  }   
  depends_on = [module.private_dns_zones]  
```

### 4.3
#### Add private dns module into the "main.tf" file:

```bash
module "private_dns_zones" {
  source                = "Azure/avm-res-network-privatednszone/azurerm"  

  enable_telemetry      = true
  resource_group_name   = azurerm_resource_group.this.name
  domain_name           = "privatelink.vaultcore.azure.net"
  dns_zone_tags         = {
    env = local.global_settings.environment 
  }
  virtual_network_links = {
      vnetlink1 = {
        vnetlinkname     = "vnetlink1"
        vnetid           = local.remote.networking.virtual_networks.spoke_project.virtual_network.id  
        autoregistration = false # true
        tags = {
          env = local.global_settings.environment 
        }
      }
    }
}
```

### 4.4
#### Add key valult access policy into the "main.tf" file:

```bash
resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = module.keyvault.resource.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = ["Get"]
  secret_permissions = ["Get"]
}
```

## Step 5
### Navigate to the directory: 
#### /tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/keyvault

```bash
cd /tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/keyvault
```

## Step 6
### Execute Terraform commands to initialize, plan, and apply configurations:

### Initialize Terraform with backend configuration
```bash
terraform init  -reconfigure \
-backend-config="resource_group_name={{resource group name}}" \
-backend-config="storage_account_name={{storage account name}}" \
-backend-config="container_name=2-solution_accelerators" \
-backend-config="key=solution_accelerators-project-keyvault.tfstate"
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