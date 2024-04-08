resource "azurerm_container_registry" "acr" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.sku  
  admin_enabled            = var.admin_enabled
  tags                     = var.tags

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.acr_identity.id
    ]
  }

  dynamic "georeplications" {
    for_each = var.georeplication_locations

    content {
      location = georeplications.value
      tags     = var.tags
    }
  }

  lifecycle {
      ignore_changes = [
          tags
      ]
  }
}

resource "azurerm_user_assigned_identity" "acr_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  name = "${var.name}Identity"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = ">= 0.3.0"
  # prefix                 = ["${local.global_settings.prefix}"] 
  unique-seed            = "random"
  unique-length          = 3
  unique-include-numbers = false  
}

resource "azurerm_monitor_diagnostic_setting" "settings" {
  name                       = "${module.naming.monitor_diagnostic_setting.name_unique}-acr" # "DiagnosticsSettings"
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "ContainerRegistryRepositoryEvents"

    retention_policy {
      enabled = true
      # days    = var.log_analytics_retention_days
    }
  }

  enabled_log {
    category = "ContainerRegistryLoginEvents"

    retention_policy {
      enabled = true
      # days    = var.log_analytics_retention_days
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      # days    = var.log_analytics_retention_days
    }
  }
}