module "diagnosticsetting1" {
  source  = "./../../../../../../modules/diagnostics/terraform-azurerm-diagnosticsetting"

  name                = "${module.naming.monitor_diagnostic_setting.name_unique}-kv"
  target_resource_id = module.keyvault.resource.id
  log_analytics_workspace_id = local.remote.log_analytics_workspace.id
  diagnostics = {
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AuditEvent", true, false, 14],
        ["AzurePolicyEvaluationDetails", true, false, 14],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }
  }
}
