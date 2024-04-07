output "mssql_server_resource" {
  value       = module.mssql_server.resource 
  description = "The Azure keyvault resource"
  sensitive = true  
}

output "mssql_database_resource" {
  value       = module.mssql_database.resource 
  description = "The Azure keyvault resource"
  sensitive = true  
}

output "mssql_elastic_pool_resource" {
  value       = module.mssql_elastic_pool.resource 
  description = "The Azure keyvault resource"
  sensitive = true  
}

output "global_settings" {
  value       = local.global_settings
  description = "The framework global_settings"
}
