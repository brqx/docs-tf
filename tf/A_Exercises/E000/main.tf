# main.tf
# -----------------------------------------------------------
# Exercise E000

# Region actual de Terraform
data "aws_region" "current" {}

locals {
  prefix          = "amazon-exercises-terraform"
  vpc_name        = "${local.prefix}-vpc"
  vpc_cidr        = var.vpc_cidr
  vpc_cidr_blocks = var.vpc_cidr_blocks
  
  common_tags = {
    Environment = "dev"
    Project     = "RMB-TF-E001"
  }
}
