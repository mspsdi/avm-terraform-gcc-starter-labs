# output "private_endpoints" {
#   description = "A map of private endpoints. The map key is the supplied input to var.private_endpoints. The map value is the entire azurerm_private_endpoint resource."
#   value       = azurerm_private_endpoint.this
# }

output "resource" {
  depends_on = [
    azurerm_container_group.this,
  ]
  description = "The Key Vault resource."
  value       = azurerm_container_group.this
}

# output "resource_keys" {
#   description = "A map of key objects. The map key is the supplied input to var.keys. The map value is the entire azurerm_key_vault_key resource."
#   value       = azurerm_key_vault_key.this
# }

# output "resource_secrets" {
#   description = "A map of secret objects. The map key is the supplied input to var.secrets. The map value is the entire azurerm_key_vault_secret resource."
#   value       = azurerm_key_vault_secret.this
# }
