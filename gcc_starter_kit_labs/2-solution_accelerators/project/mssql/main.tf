resource "azurerm_user_assigned_identity" "this" {
  name                = "msi-sqlserver"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

module "mssql_server" {
  source = "./../../../../../../modules/databases/terraform-azurerm-sql-server"
  depends_on = [
    azurerm_user_assigned_identity.this, 
    module.keyvault,
  ]  

  name                          = "${module.naming.mssql_server.name}${random_string.this.result}" # module.naming.mssql_server.name_unique 
  resource_group_name           = azurerm_resource_group.this.name 
  location                      = azurerm_resource_group.this.location 
  mssql_version                 = "12.0" 
  administrator_login           = "sqladminuser" 
  administrator_login_password  = module.keyvault.resource_secrets["sql_admin_password"].value 
  public_network_access_enabled = true 
  connection_policy             = "Default" 
  minimum_tls_version           = "1.2" 
  tags = { 
    purpose = "mssql server" 
    project_code = local.global_settings.prefix 
    env = local.global_settings.environment 
    zone = "project"
    tier = "db"           
  }   

  azuread_administrator = {
    azuread_authentication_only = false
    login_username = azurerm_user_assigned_identity.this.name
    object_id      = azurerm_user_assigned_identity.this.principal_id
  }

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  primary_user_assigned_identity_id            = azurerm_user_assigned_identity.this.id

}

module mssql_elastic_pool {
  source = "./../../../../../../modules/databases/terraform-azurerm-sql-elasticpool"
  depends_on = [module.mssql_server]  

  name                = "${module.naming.mssql_elasticpool.name}${random_string.this.result}" # module.naming.mssql_elasticpool.name_unique 
  resource_group_name = azurerm_resource_group.this.name 
  location            = azurerm_resource_group.this.location 
  server_name         = module.mssql_server.resource.name 
  max_size_gb         = "756" 
  max_size_bytes      = null 
  zone_redundant      = false 
  license_type        = "LicenseIncluded" 
  tags                = {
    env = local.global_settings.environment 
  } 

  sku = {
    name     = "GP_Gen5"
    tier     = "GeneralPurpose" # Possible values are GeneralPurpose, BusinessCritical, Basic, Standard, Premium, or HyperScale
    family   = "Gen5"
    capacity = 4
  }

  per_database_settings = {
    min_capacity = 0.25
    max_capacity = 4
  }
}

module mssql_database {
  source = "./../../../../../../modules/databases/terraform-azurerm-sql-database"
  depends_on = [module.mssql_server]  

  name               = "${module.naming.mssql_database.name}${random_string.this.result}" # module.naming.mssql_database.name_unique 
  resource_group_name = azurerm_resource_group.this.name 
  server_id   = module.mssql_server.resource.id 
  # to avoid update due to "geo_backup_enabled = true -> false"
  # geo_backup_enabled is only applicable for DataWarehouse SKUs (DW*). This setting is ignored for all other SKUs.
  geo_backup_enabled = true # since it is ignore caf terraform is default is false
  license_type   = "LicenseIncluded"
  max_size_gb    = 1
  sku_name       = "S0"
  zone_redundant = false # true

  tags = { 
    purpose = "mssql database" 
    project_code = local.global_settings.prefix 
    env = local.global_settings.environment 
    zone = "project"
    tier = "db"           
  }   
}

