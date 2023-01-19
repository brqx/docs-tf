# ----------------------------------------------------------
# Info - 2022_Jul
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------

data "aws_region" "current" {}

locals {
  region = data.aws_region.current.id
  key    = "farmacia2022_rsa"
  ami    = data.aws_ami.amzUbuntu.id
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # version = "~> 4.0" --> Falla - 2022 Jul
      # Le decimos que coja la inmediatamente superior
      version = "~> 3.74"
    }
  }
}

# Esto admite variables pero no funciona
provider "aws" {
  region  = "eu-west-1"
  profile = "tf"
}

# El prefijo va a informar del proyecto relacionado con el recurso
# Ej : raad-dev
# Recipe App Api Devops
# prefix : ejemplo-tf-001-dev
locals {
  prefix = "${var.prefix}-${terraform.workspace}"

  # Variables de la VPC
  vpc_name      = "${local.prefix}-vpc"
  vpc_cidr      = var.vpc_cidr

  project_general = ${var.project_general}

  # Usamos worksapce para el entorno
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    Owner       = var.contact
    ManagedBy   = "Terraform-Brqx"
  }
}

## terraform workspace select staging