# public_subnets.tf
# ------------------------------------------------------------
# Exercise E001 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_subnet - 
# aws_route_table - aws_route_table_association - aws_route
# ------------------------------------------------------------

#Subnets with bucles

#####################################################
# Public Subnets - Inbound/Outbound Internet Access #
#####################################################
# aws_subnet.public["zone_b"]
resource "aws_subnet" "public" {

  # Generate cidr block 10.20.1.0/24  --> Args ( 10.20.0.0/16 ,  8  ,  1 )
  cidr_block              = cidrsubnet(local.vpc_cidr, local.vpc_cidr_blocks, var.azs["zone_a"].cidr)
  map_public_ip_on_launch = true
  vpc_id                  = local.vpc_id
  availability_zone       = "${data.aws_region.current.name}${var.azs["zone_a"].az}"

  tags = merge( local.common_tags, tomap({ "Name" = "${local.prefix}-${var.azs["zone_a"].name}" })  )
}


# ----------------------------------------------------------

# aws_route_table.public["zone_b"]
# No decimos ninguna ruta
resource "aws_route_table" "public" {
  
  vpc_id = local.vpc_id

  # Lo que pertenezca al CIDR debe salir por internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = local.igw_id
  }
  
  tags = merge(  local.common_tags,  tomap({ "Name" = "${local.prefix}-${var.azs["zone_a"].az}-routetable" })   )
}

# ----------------------------------------------------------

# Relaciona Subnet - Route Table
resource "aws_route_table_association" "public" {

  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
# ----------------------------------------------------------

# Exercise E001_cc - New Entities

# aws_eip
# aws_nat_gateway

# Disabled due to long generation time


