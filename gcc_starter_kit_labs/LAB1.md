# Step 1. Perform Azure login by executing the following commands:

az login --tenant <your tenant id> 
az account set --subscription <your subscription id>

# Step 2. Navigate to the directory for setting up GCC development environment:

cd /tf/avm/gcc_starter_kit/0-setup_gcc_dev_env

# Step 3. Execute Terraform commands to initialize, plan, and apply configurations:

terraform init -reconfigure
terraform plan
terraform apply -auto-approve


# Step 4. Verify your Azure resource in Azure portal


