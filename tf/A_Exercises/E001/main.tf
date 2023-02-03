# main.tf
# -----------------------------------------------------------
# Exercise E001

# Region actual de Terraform ( creo que del perfil )
data "aws_region" "current" {}

locals {
  prefix          = "amazon-exercises-terraform"
  vpc_name        = "${local.prefix}-vpc"
  vpc_cidr        = var.vpc_cidr
  vpc_cidr_blocks = var.vpc_cidr_blocks

  # Preparamos las referencias para cuando se cargue la zona

  vpc_id          =  aws_vpc.main.id
  igw_id          =  aws_internet_gateway.main.id

  common_tags = {
    Environment = "dev"
    Project     = "RMB-TF-E001"
  }
}
