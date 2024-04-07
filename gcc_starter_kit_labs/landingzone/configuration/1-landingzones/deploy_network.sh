
#!/bin/bash

# sudo chmod -R -f 777 /tf/avm/gcc_starter_kit/deploy_network.sh

# exit bash script when encounter error
# set -e

# cd /tf/avm/gcc_starter_kit
# ./deploy_network.sh


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


# common services landingzone

if [ $? -eq 0 ]; then
  CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones/common_services/networking_hub_internet_ingress
  executeTerraform
fi 

if [ $? -eq 0 ]; then
  CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones/common_services/networking_hub_intranet_ingress
  executeTerraform
fi 

if [ $? -eq 0 ]; then
  CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones/common_services/networking_hub_internet_egress
  executeTerraform
fi 

if [ $? -eq 0 ]; then
  CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones/common_services/networking_hub_intranet_egress
  executeTerraform
fi 


if [ $? -eq 0 ]; then
  CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones/common_services/networking_spoke_management
  executeTerraform
fi 

# applications landingzone

if [ $? -eq 0 ]; then
  CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones/applications/networking_spoke_devops
  executeTerraform
fi 

if [ $? -eq 0 ]; then
  CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones/applications/networking_spoke_project
  executeTerraform
fi 

if [ $? -eq 0 ]; then
  CURRENT_DIR=/tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones/applications/networking_peering
  executeTerraform
fi 

echo "end deploying gcc starter kit"



