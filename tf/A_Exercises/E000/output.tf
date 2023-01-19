# Fichero de salida

output "prefix" {
  value       = local.prefix
  description = "Exported common resources prefix"
}

output "common_tags" {
  value       = local.common_tags
  description = "Exported common resources tags"
}

output "region" {
  value       = data.aws_region.current.id
  description = "Exported region"
}
