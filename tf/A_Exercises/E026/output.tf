# output.tf
#-------------------------------------# ------------------------------------------------------------
# Exercise E024 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# New Output : 
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

# Nuevos outputs del E001

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "vpc_cidr" {
  value       = aws_vpc.main.cidr_block
  description = "VPC CIDR block"
}

output "igw_id" {
  value       = aws_internet_gateway.main.id
  description = "GTW ID"
}


# Nuevos outputs del E006


output "vpc_region" {
  value       = data.aws_region.current.name
  description = "Region del EFS"
}

# Nuevos output del E023

# Este valor devuelve true : associate_public_ip_address
output "instance_ip" {
  value       = aws_instance.amazon_linux_2.public_ip
  description = "IP publica de la instancia EC2"
}


output "time" {
  value       = timestamp()
  description = "Timestamp"
}

# Nuevos Output de DynamoDb

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
