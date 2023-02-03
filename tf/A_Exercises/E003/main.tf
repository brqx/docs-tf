# main.tf
# -----------------------------------------------------------
# Exercise E003

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

  # Key_name es el nombre de la clave. no donde esta
  key_name = "farmacia2022_rsa"

  key_name_public = "${var.keys_folder}farmacia2022_rsa.pub"

  tf_shell_path = "${var.project_path}x/"

  ssh_secret_port = var.ssh_secret_port

  ec2_instance_type = "t3.micro"

  common_tags = {
    Environment = "dev"
    Project     = "RMB-TF-E001"
  }
}
