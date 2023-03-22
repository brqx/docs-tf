# main.tf
# ------------------------------------------------------------
# Exercise E021 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# 
# ------------------------------------------------------------


# Region actual de Terraform ( creo que del perfil )
data "aws_region" "current" {}

# Account ID
data "aws_caller_identity" "current" {}

# Account ID for Logs
data "aws_elb_service_account" "main" {}

locals {

  prefix = "amazon-exercises-terraform"

  account_id = data.aws_caller_identity.current.id

  resource_name = "alb_asg-prueba"
  max_instance = 10
  min_instance = 1

  aws_region = data.aws_region.current.name

  # Preparamos las referencias para cuando se cargue la zona

  # Es el nombre de la clave - no su ruta
  key_name = "farmacia2022_rsa"

  tf_shell_path = "${var.project_path}x/"

  ec2_instance_type = "t3.micro"

  ssh_secret_port   = var.ssh_secret_port


  # Variables Para S3
  
  common_tags = {
    Environment = "dev"
    Project     = "RMB-TF-E001"
  }
}
