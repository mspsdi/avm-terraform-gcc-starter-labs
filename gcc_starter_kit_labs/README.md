# goto working directory
cd /tf/avm/gcc_starter_kit

# import gcci tfstate and create launchpad storage account and containers
cd /tf/avm/gcc_starter_kit/landingzone/configuration/0-launchpad/launchpad
./import.sh

# create virtual subnets, nsg, routing tables
cd /tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones
./deploy_network.sh

# create solution accelerators
cd /tf/avm/gcc_starter_kit/landingzone/configuration/2-solution_accelerators
./deploy_solution_accelerators_common_services.sh
./deploy_solution_accelerators_application_shared_services.sh
./deploy_solution_accelerators_application_aks_architype.sh
./deploy_solution_accelerators_application_app_service_architype.sh
./deploy_solution_accelerators_application_open_ai_architype.sh


# ----------------------------------------------------------------------
# gcci platform terraform state file
# ----------------------------------------------------------------------

sudo chmod -R -f 777 /tf/caf/gcc_starter_kit/landingzone/configuration/level0/gcci_platform/import.sh

cd /tf/caf/gcc_starter_kit/landingzone/configuration/0-launchpad/launchpad

./import.sh

# ----------------------------------------------------------------------
# networking
# ----------------------------------------------------------------------

cd /tf/caf/gcc_starter_kit

./deploy_network.sh

# ----------------------------------------------------------------------
# solution accelerators
# ----------------------------------------------------------------------

cd /tf/caf/gcc_starter_kit

./deploy_aks_pattern.sh
./deploy_app_service_pattern.sh
./deploy_open_ai_pattern.sh



