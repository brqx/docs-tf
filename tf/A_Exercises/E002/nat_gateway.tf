# nat_gateway.tf
# -----------------------------------------------------------
# Exercise E002 

# TF Entities : 
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
