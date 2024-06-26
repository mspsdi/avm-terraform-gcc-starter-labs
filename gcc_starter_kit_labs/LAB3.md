# Lab 3 - Create Virtual Subnets

## Step 1
### Navigate to the landingzone applications directory: 
#### /tf/avm/gcc_starter_kit_labs/landingzone/configuration/1-landingzones/applications.

```bash
cd /tf/avm/gcc_starter_kit_labs/landingzone/configuration/1-landingzones/applications
```

## Step 2
### Duplicate the folder named "networking_template" and rename the duplicate as "networking_project".

## Step 3
### In the file "resource_groups.tf" of networking_project folder, locate line 2 and replace "yourvnetname" with "project".

## Step 4
### Confirm that in the file "main.virtual_subnets.tf" line 4-6 reads as follows:

```bash
  virtual_network_name  = local.remote.networking.virtual_networks.spoke_project.virtual_network.name 
  resource_group_name   = local.remote.resource_group.name 
  subnets = local.global_settings.subnets.project
```

Note: 
- virtual_network_name is assigned to the name from the local variables define in the AAF framework.
- resource_group_name is assigned to the resource group from the local variables define in the AAF framework.
- subnets is assigned to the variables from the config.yaml file you define in lab 2.

## Step 5
### (optional) remove unwanted files if required

```bash
cd /tf/avm/gcc_starter_kit_labs/landingzone/configuration/1-landingzones/applications/networking_project
rm main.diagnostics.tf
rm main.network_security_groups.tf
rm main.route_tables.tf
```

## Step 5
### Navigate to the networking project directory: 
#### /tf/avm/gcc_starter_kit_labs/landingzone/configuration/1-landingzones/applications/networking_project

```bash
cd /tf/avm/gcc_starter_kit_labs/landingzone/configuration/1-landingzones/applications/networking_project
```

## Step 6
### Execute Terraform commands to initialize, plan, and apply configurations:

### Initialize Terraform with backend configuration
```bash
terraform init  -reconfigure \
-backend-config="resource_group_name={{resource_group_name}}" \
-backend-config="storage_account_name={{storage_account_name}}" \
-backend-config="container_name=1-landingzones" \
-backend-config="key=network-spoke-project.tfstate"
```
#### Note: Ensure the key above is rename to "network-spoke-project.tfstate"

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
### Take some time to explore the remaining files within the folder to enhance your understanding.

## Step 8 (Optional)
### Add in  main.route_tables.tf
### Add in  main.network_security_groups.tf
### Add in  main.diagnostics.tf
