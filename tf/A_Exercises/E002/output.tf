# Fichero de salida

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

# Nuevos outputs del E001 (variante bb)

# En los output tampoco permite hacer un bucle aunque no tengamos foreach definido en las estructuras
# pero no se ve al validar sino al aplicar
# Can't access attributes on a primitive-typed value (string)

output "public_subnets_cidr" {
  value       = aws_subnet.public.cidr_block
  description = "Public subnets CIDRs list"
}

output "public_subnets_ids" {
  value       = aws_subnet.public.id
  description = "Public subnets IDs list"
}

# Nuevos outputs del E001 ( variante cc)

output "eip" {
  value       = aws_eip.main.public_ip
  description = "Nat Gateway ID"
}

output "natgw_id" {
  value       = aws_nat_gateway.main.id
  description = "Nat Gateway ID"
}