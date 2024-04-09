# Lab 1 - Setup GCC Development Environment

## Step 1
### Perform Azure login by executing the following commands:

```bash
az login --tenant <your tenant id> 
az account set --subscription <your subscription id>

# show your login account
az account show
```

## Step 2
### Navigate to the directory for setting up GCC development environment:

```bash
cd /tf/avm/gcc_starter_kit_labs/0-setup_gcc_dev_env
```

## Step 3
### Execute Terraform commands to initialize, plan, and apply configurations:

```bash
terraform init -reconfigure
terraform plan
terraform apply -auto-approve
```

## Step 4
### Verify your Azure resources in Azure portal


