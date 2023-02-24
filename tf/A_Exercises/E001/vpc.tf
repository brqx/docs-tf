# vpc.tf
# -----------------------------------------------------------
# Exercise E001 .. E00N
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_vpc - aws_internet_gateway
# -----------------------------------------------------------

# Vpc

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  # prefijo - workspace - nombre
  # tf-default-vpc
  tags = merge(local.common_tags, tomap({ "Name" = "${local.prefix}-vpc" })
  )
}

# ----------------------------------------------------------

# Internet Gateway

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, tomap({ "Name" = "${local.prefix}-igw" })
  )
}
