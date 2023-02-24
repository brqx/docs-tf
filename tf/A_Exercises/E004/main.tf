# main.tf
# ------------------------------------------------------------
# Exercise E004 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# El prefijo va cambiando

# Region actual de Terraform ( creo que del perfil )
data "aws_region" "current" {}

locals {

  prefix = "amazon-exercises-terraform"

  aws_region = data.aws_region.current.name

  vpc_name        = "${local.prefix}-vpc"
  vpc_cidr        = var.vpc_cidr
  vpc_cidr_blocks = var.vpc_cidr_blocks

  # Preparamos las referencias para cuando se cargue la zona

  vpc_id = aws_vpc.main.id
  igw_id = aws_internet_gateway.main.id

  # Es el nombre de la clave - no su ruta
  key_name = "farmacia2022_rsa"

  tf_shell_path = "${var.project_path}x/"

  ec2_instance_type = "t3.micro"

  ssh_secret_port   = var.ssh_secret_port

  # Variables Para S3

  s3_bucket_name = var.s3_bucket_name
  s3_sid_name    = var.s3_sid_name

  common_tags = {
    Environment = "dev"
    Project     = "RMB-TF-E001"
  }
}
