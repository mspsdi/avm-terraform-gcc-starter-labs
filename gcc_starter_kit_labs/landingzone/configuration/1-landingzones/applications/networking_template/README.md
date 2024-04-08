cd /tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones/applications/networking_spoke_project

terraform init  -reconfigure \
-backend-config="resource_group_name=ttsdev-rg-launchpad" \
-backend-config="storage_account_name=ttsdevstgtfstategof" \
-backend-config="container_name=1-landingzones" \
-backend-config="key=network-spoke-project.tfstate"

terraform plan \
-var="storage_account_name=ttsdevstgtfstategof" \
-var="resource_group_name=ttsdev-rg-launchpad"

terraform apply -auto-approve \
-var="storage_account_name=ttsdevstgtfstategof" \
-var="resource_group_name=ttsdev-rg-launchpad"
