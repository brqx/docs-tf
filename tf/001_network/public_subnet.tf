# ----------------------------------------------------------
# Info - 2022_Jul
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------

# TF Entities : 
# aws_subnet - 
# aws_route_table - aws_route_table_association - aws_route
# aws_eip
# aws_nat_gateway
# ----------------------------------------------------------

#Subnets with bucles

#####################################################
# Public Subnets - Inbound/Outbound Internet Access #
#####################################################
# aws_subnet.public["zone_b"]
resource "aws_subnet" "public" {
  for_each = var.azs

  cidr_block              = each.value.cidr
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${data.aws_region.current.name}${each.value.az}"

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-${each.value.name}" })
  )
}

# ----------------------------------------------------------

# aws_route_table.public["zone_b"]
resource "aws_route_table" "public" {
  for_each = var.azs

  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-${each.value.az}-routetable" })
  )
}

# ----------------------------------------------------------

# Relaciona Subnet - Route Table
resource "aws_route_table_association" "public" {
  for_each = var.azs

  subnet_id      = aws_subnet.public["${each.key}"].id
  route_table_id = aws_route_table.public["${each.key}"].id
}

# ----------------------------------------------------------

resource "aws_eip" "public" {
  for_each = var.azs

  vpc = true

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-${each.value.name}-EIP" })
  )
}

# ----------------------------------------------------------


resource "aws_nat_gateway" "public" {
  for_each = var.azs

  allocation_id = aws_eip.public["${each.key}"].id
  subnet_id     = aws_subnet.public["${each.key}"].id

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-${var.azs["${each.key}"].name}-NATGW" })
  )
}
