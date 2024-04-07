module "log_analytics_workspace" {
  source  = "./../../modules/diagnostics/terraform-azurerm-mspsdi-avm-res-diagnostics-loganalyticsworkspace"

  name                             = local.log_analytics_workspace_name 
  location                         = var.location
  resource_group_name              = azurerm_resource_group.gcci_agency_law.name
  solution_plan_map                = var.solution_plan_map
  tags                             = var.tags
}

