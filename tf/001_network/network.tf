# ----------------------------------------------------------
# Info - 2022_Jul
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------

# TFEntity | TFE : aws_vpc - aws_internet_gateway 

resource "aws_vpc" "main" {
  cidr_block           = "30.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  # prefijo - workspace - nombre
  # tf-default-vpc
  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-vpc" })
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-main" })
  )
}
