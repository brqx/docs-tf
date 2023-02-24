# private_subnets.tf
# ------------------------------------------------------------
# Exercise E001 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_subnet - 
# aws_route_table - aws_route_table_association
# ------------------------------------------------------------

#####################################################
# Private Subnets - Inbound Internet Access #
#####################################################
resource "aws_subnet" "private" {

  # Generate cidr block 10.20.1.0/24  --> Args ( 10.20.0.0/16 ,  8  ,  1 )
  cidr_block              = cidrsubnet(local.vpc_cidr, local.vpc_cidr_blocks, var.azs["zone_a"].pvcidr)
  map_public_ip_on_launch = true
  vpc_id                  = local.vpc_id
  availability_zone       = "${data.aws_region.current.name}${var.azs["zone_a"].az}"

  tags = merge( local.common_tags, tomap({ "Name" = "${local.prefix}-${var.azs["zone_a"].pvname}" })  )
}

# ----------------------------------------------------------

# Tabla de rutas Subred privada
resource "aws_route_table" "private" {
  vpc_id = local.vpc_id

  # La subred privada solo puede salir
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
  tags = merge(
    local.common_tags, tomap({ "Name" = "${local.prefix}-${var.azs["zone_a"].pvname}-routetable" })
  )
}

# ----------------------------------------------------------

# Asocia Subnet con Tabla de rutas
resource "aws_route_table_association" "private" {

  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}


