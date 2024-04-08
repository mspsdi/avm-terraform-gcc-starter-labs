# Lab 4 - Create Solution Accelerator Virtual Machine
## Step 1
### Navigate to the solution accelerators project directory: 
#### /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project.

```bash
cd /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project
```

## Step 2
### Duplicate the folder named "solution_accelerators_template" and rename the duplicate as "vm".

```bash
cp /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project/solution_accelerators_template /tf/avm/gcc_starter_kit_labs/landingzone/configuration/2-solution_accelerators/project/vm
```

## Step 3
### In the file resource_groups.tf, locate line 2 and replace "yourresourcegroup" with "vm".

## Step 4
### Configure Virtual Machine terraform module

### 4.1
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

### 4.2
#### After line 9 of the module above, include the following Virtual Machine configurations:

```bash
  virtualmachine_os_type                 = "Windows"
  name                                   = module.naming.virtual_machine.name_unique
  virtualmachine_sku_size                = "Standard_DS1_v2" # module.get_valid_sku_for_deployment_region.sku
  admin_username                         = "adminuser"
  admin_password                         = "P@ssw0rd1234!"  # Please replace this with your own secure password

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
          name                          = "${module.naming.network_interface.name_unique}-ipconfig1"
          private_ip_subnet_resource_id = local.remote.networking.virtual_networks.spoke_project.virtual_subnets.subnets["AppSubnet"].id 
          create_public_ip_address      = false # true
          public_ip_address_name        = null # module.naming.public_ip.name_unique
        }
      }
    }
  }

  data_disk_managed_disks = {
    disk1 = {
      name                 = "${module.naming.managed_disk.name_unique}-lun0"
      storage_account_type = "StandardSSD_LRS"
      lun                  = 0
      caching              = "ReadWrite"
      disk_size_gb         = 32
    }
  }

  tags = {
    scenario = "windows_w_data_disk_and_public_ip"
  }
```

### 4.3 goto line 1 of output.tf to add in the below output code

```bash
output "vm_ip_address" {
  value = azurerm_windows_virtual_machine.example.private_ip_address
}
```

## Step 5
### Navigate to the directory: 
#### /tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/vm

```bash
cd /tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/vm
```

## Step 6
### Execute Terraform commands to initialize, plan, and apply configurations:

### Initialize Terraform with backend configuration
```bash
terraform init  -reconfigure \
-backend-config="resource_group_name={{resource group name}}" \
-backend-config="storage_account_name={{storage account name}}" \
-backend-config="container_name=2-solution_accelerators" \
-backend-config="key=solution_accelerators-project-vm.tfstate"
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