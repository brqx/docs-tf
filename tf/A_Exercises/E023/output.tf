# output.tf
#-------------------------------------# ------------------------------------------------------------
# Exercise E014 .. E00n
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


output "cola" {
  value       = aws_sqs_queue.main.id
  description = "SQS Queue URL"
}