# ----------------------------------------------------------
# Info - 2022_Jul
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------

# TF Entities : 
# aws_subnet - 
# aws_route_table - aws_route_table_association - aws_route
# ----------------------------------------------------------

#Subnets with bucles

#####################################################
# Public Subnets - Inbound/Outbound Internet Access #
#####################################################
# aws_subnet.public["zone_b"]
resource "aws_subnet" "public" {
  # for_each = var.azs

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

  # Sabia que faltaban las rutas
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


# ----------------------------------------------------------

resource "aws_eip" "main" {

  vpc = true

  tags = merge( local.common_tags, tomap({ "Name" = "${local.prefix}-${var.azs["zone_a"].name}-EIP" })
  )
}

# ----------------------------------------------------------

# Se define en una subnet (AZ) y se le indica que EIP usar
resource "aws_nat_gateway" "main" {

  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public.id

  tags = merge( local.common_tags,  tomap({ "Name" = "${local.prefix}-${var.azs["zone_a"].name}-NATGW" })
  )
}
