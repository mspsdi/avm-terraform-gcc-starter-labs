output "cosmos_db_id" {
  value       = module.cosmos_db.cosmosdb_id 
  description = "The Azure Acr resource"
  sensitive = true  
}

output "global_settings" {
  value       = local.global_settings
  description = "The framework global_settings"
}
