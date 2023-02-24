# output.tf
# ------------------------------------------------------------
# Exercise E007 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

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

# Nuevos outputs del E002

# Retorno : eu-west-1a
output "instance_az" {
  value       = aws_instance.amazon_linux_2.availability_zone
  description = "Zona de disponibilidad de la instancia EC2"
}

# Este valor devuelve true : associate_public_ip_address
output "instance_ip" {
  value       = aws_instance.amazon_linux_2.public_ip
  description = "IP publica de la instancia EC2"
}

# Nuevos outputs del E006

output "efs_target" {
  value       = aws_efs_mount_target.alpha.file_system_id
  description = "Id del mount target a montar"
}

output "vpc_region" {
  value       = data.aws_region.current.name
  description = "Region del EFS"
}

# Nuevos outputs del E007

output "efs_ap" {
  value       = aws_efs_access_point.drupal.id
  description = "Id del Access Point del sisteme EFS a montar"
}
