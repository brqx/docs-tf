# ----------------------------------------------------------
# Info - 2022_Jul
# Terraform v1.2.6
# + provider.aws v3.37.0
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

resource "aws_route_table" "private" {
  for_each = var.azs

  vpc_id = aws_vpc.main.id

  # La subred privada solo puede salir
  route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.public["${each.key}"].id
    }
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-${each.value.pvname}-routetable" })
  )
}

resource "aws_route_table_association" "private" {
  for_each = var.azs

  subnet_id      = aws_subnet.private["${each.key}"].id
  route_table_id = aws_route_table.private["${each.key}"].id
}

resource "aws_route" "private_internet_out" {
  for_each = var.azs

  route_table_id         = aws_route_table.private["${each.key}"].id
  nat_gateway_id         = aws_nat_gateway.public["${each.key}"].id
  destination_cidr_block = "0.0.0.0/0"
}

