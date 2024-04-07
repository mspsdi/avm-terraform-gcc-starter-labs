# data "terraform_remote_state" "acr" {
#   backend = "azurerm"

#   config = {
#     resource_group_name  = "{{resource_group_name}}" 
#     storage_account_name = "aoaidevstgtfstatejfx" 
#     container_name       = "2-solution-accelerators"
#     key                  = "solution-accelerators-acr.tfstate" 
#   }
# }

# locals {
#   remote = {
#     acr = { 
#       data.terraform_remote_state.acr.outputs.acr_resource
#     }
#   }
# }