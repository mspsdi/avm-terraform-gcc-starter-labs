# Lab 5 - Create Solution Accelerator Virtual Machine
## Step 1
### Navigate to the solution accelerators project lab directory: 
#### /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project/lab.

```bash
cd /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project/lab
```

## Step 2
### Configure Virtual Machine terraform module

### 2.1
#### Insert the following lines into the "main.tf" file:

```bash
module "virtualmachine1" {
  source = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.1.0"

  enable_telemetry                       = var.enable_telemetry
  location                               = azurerm_resource_group.this.location
  resource_group_name                    = azurerm_resource_group.this.name
  # add your virtual machine configuration below

}
```

### 2.2
#### After line 9 of the module above, include the following Virtual Machine configurations:

```bash
  virtualmachine_os_type                 = "Windows"
  name                                   = "${module.naming.virtual_machine.name}${random_string.this.result}" 
  admin_credential_key_vault_resource_id = module.keyvault1.resource.id
  virtualmachine_sku_size                = "Standard_D2s_v3" # "Standard_D2s_v3" # "standard_d2_v2" # "Standard_D2s_v3" # "standard_d2_v2" "Standard_D8s_v3" 
  zone                                   = "1" # random_integer.zone_index.result 

  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-g2"
    version   = "latest"
  }

  network_interfaces = {
    network_interface_1 = {
      name = module.naming.network_interface.name_unique
      ip_configurations = {
        ip_configuration_1 = {
          name                          = "${module.naming.network_interface.name}-ipconfig1"
          private_ip_subnet_resource_id = local.remote.networking.virtual_networks.spoke_project.virtual_subnets.subnets["AppSubnet"].id 
          create_public_ip_address      = false # true
          public_ip_address_name        = null # module.naming.public_ip.name_unique
        }
      }
    }
  }

  data_disk_managed_disks = {
    disk1 = {
      name                 = "${module.naming.managed_disk.name}-lun0"
      storage_account_type = "StandardSSD_LRS"
      lun                  = 0
      caching              = "ReadWrite"
      disk_size_gb         = 32
    }
  }

  depends_on = [
    module.keyvault1
  ]
```

## Step 3
### Navigate to the directory: 
#### /tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/lab

```bash
cd /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project/lab
```

## Step 4
### Execute Terraform commands to initialize, plan, and apply configurations:

### Note: Please replace {{resource group name}} and {{storage account name}} with the actual names of the resource group and storage account created during Lab1.

### Initialize Terraform with backend configuration
```bash
terraform init  -reconfigure \
-backend-config="resource_group_name={{resource group name}}" \
-backend-config="storage_account_name={{storage account name}}" \
-backend-config="container_name=2-solution-accelerators" \
-backend-config="key=solution_accelerators-project-lab.tfstate"
```
#### Note: Ensure the key above is rename to "solution_accelerators-project-vm.tfstate"

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

## Step 5
### Verify your Azure resources in Azure portal

