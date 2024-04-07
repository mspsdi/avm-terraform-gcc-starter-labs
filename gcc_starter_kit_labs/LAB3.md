# Lab 3 - Create Virtual Subnets

## Step 1
### Navigate to the directory: /tf/avm/gcc_starter_kit_labs/landingzone/configuration/1-landingzones/applications.

```bash
cd /tf/avm/gcc_starter_kit_labs/landingzone/configuration/1-landingzones/applications
```

## Step 2
### Duplicate the folder named "network_template" and rename the duplicate as "network_project".

## Step 3
### In the file "resource_groups.tf", locate line 2 and replace "yourvnetname" with "project".

## Step 4
### Confirm that in the file "main.virtual_subnets.tf", line 6 reads as follows:

```bash
subnets = local.global_settings.subnets.project
```

## Step 5
### Navigate to the directory: /tf/avm/gcc_starter_kit_labs/landingzone/configuration/1-landingzones/applications/networking_project

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

## Step 7
### Take some time to explore the remaining files within the folder to enhance your understanding.
