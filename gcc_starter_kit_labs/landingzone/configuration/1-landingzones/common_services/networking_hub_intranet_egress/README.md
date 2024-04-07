cd /tf/avm/gcc_starter_kit/landingzone/configuration/1-landingzones/common_services/networking_hub_intranet_egress

terraform init  -reconfigure \
-backend-config="resource_group_name={{resource_group_name}}" \
-backend-config="storage_account_name={{storage_account_name}}" \
-backend-config="container_name=1-landingzones" \
-backend-config="key=network-hub-intranet-egress.tfstate"

terraform plan \
-var="storage_account_name={{storage_account_name}}" \
-var="resource_group_name={{resource_group_name}}"

terraform apply -auto-approve \
-var="storage_account_name={{storage_account_name}}" \
-var="resource_group_name={{resource_group_name}}"

