# output.tf
#-------------------------------------# ------------------------------------------------------------
# Exercise E025 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# New Output : 
# alb_url
# 
# ------------------------------------------------------------

# Outputs del E000

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

# Nuevos output del E013

output "time" {
  value       = timestamp()
  description = "Timestamp"
}

# Devuelve el id
output "tabla_id" {
  value       = aws_dynamodb_table.main.id
  description = "DynamodB Table URL"
}

# Devuelve el arn
output "tabla_arn" {
  value       = aws_dynamodb_table.main.arn
  description = "DynamodB Table ARN"
}

# stream_arn : el ARN de la secuencia de tabla. Solo disponible cuando stream_enabled = true