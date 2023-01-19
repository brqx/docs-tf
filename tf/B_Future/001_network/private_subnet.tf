# ----------------------------------------------------------
# Info - 2022_Jul
# Terraform v1.2.6
# + provider.aws v3.37.0
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# TF Ent: aws_subnet - aws_route_table - aws_route_table_association
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Ver: 0.0.1 - 2022_Aug
# ----------------------------------------------------------
##################################################
# Private Subnets - Outbound internt access only #
##################################################
resource "aws_subnet" "private" {
  for_each = var.azs

  cidr_block        = each.value.pvcidr
  vpc_id            = aws_vpc.main.id
  availability_zone = "${data.aws_region.current.name}${each.value.az}"

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-${each.value.pvname}" })
  )
}

# ----------------------------------------------------------

# Tabla de rutas Subred privada
resource "aws_route_table" "private" {
  for_each = var.azs

  vpc_id = aws_vpc.main.id

  # La subred privada solo puede salir
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public["${each.key}"].id
  }
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-${each.value.pvname}-routetable" })
  )
}

# ----------------------------------------------------------

# Asocia Subnet con Tabla de rutas
resource "aws_route_table_association" "private" {
  for_each = var.azs

  subnet_id      = aws_subnet.private["${each.key}"].id
  route_table_id = aws_route_table.private["${each.key}"].id
}


