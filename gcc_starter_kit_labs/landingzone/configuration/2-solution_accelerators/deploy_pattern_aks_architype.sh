
#!/bin/bash

# sudo chmod -R -f 777 /tf/avm/gcc_starter_kit/deploy_platform_test.sh

# exit bash script when encounter error
# set -e

# function: execute terraform init, plan and apply commands
executeTerraform () {
  echo "start terraform commands"
  echo "working folder: ${CURRENT_DIR}"
  cd $CURRENT_DIR
  if [ $? -eq 0 ]; then 
    terraform init -reconfigure
    if [ $? -eq 0 ]; then
      terraform plan
      if [ $? -eq 0 ]; then
        terraform apply -auto-approve
        if [ $? -eq 0 ]; then
          echo "end networking_spoke_project"    
        else
          echo "error: apply networking_spoke_project"   
          exit 5                 
        fi
      else
        echo "error: plan networking_spoke_project"
        exit 4
      fi
    else
      echo "error: init networking_spoke_project"
      exit 3
    fi
  else
    echo "error: cd networking_spoke_project"
    exit 2
  fi
  echo "end terraform commands"
}
# end function


echo "start deploying gcc starter kit"

#-----------------------------------------------------------------------------------------------------------------
# solution accelerators
#-----------------------------------------------------------------------------------------------------------------

# hub internet
if [ $? -eq 0 ]; then
  CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/hub_internet/agw
  executeTerraform
fi  

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/hub_internet/firewall_egress
#   executeTerraform
# fi  

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/hub_internet/firewall_ingress
#   executeTerraform
# fi  


# # hub intranet

# # devops
# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/devops/containter_instance
#   executeTerraform
# fi  


# # management
# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/management/bastion_host
#   executeTerraform
# fi  

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/management/vm
#   executeTerraform
# fi  


# # project
# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/acr
#   executeTerraform
# fi  

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/aks
#   executeTerraform
# fi  

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/app_service
#   executeTerraform
# fi  

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/azure_open_ai
#   executeTerraform
# fi  

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/cosmos_db
#   executeTerraform
# fi  

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/keyvault
#   executeTerraform
# fi  

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/linux_function_app
#   executeTerraform
# fi  

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/mssql
#   executeTerraform
# fi  

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/redis_cache
#   executeTerraform
# fi 

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/search_service
#   executeTerraform
# fi  

# if [ $? -eq 0 ]; then
#   CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators/project/storage_account
#   executeTerraform
# fi  


echo "end deploying gcc starter kit"



