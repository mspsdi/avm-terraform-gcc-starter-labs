output "containergroup_resource" {
  value       = {
    id = module.container_group1.resource.id
    name = module.container_group1.resource.name
  }
  description = "The Azure containter instance resource"
}

output "global_settings" {
  value       = local.global_settings
  description = "The framework global_settings"
}
