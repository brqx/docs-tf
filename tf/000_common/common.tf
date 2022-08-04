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
  backend "s3" {
    # Aqui no se permiten variables
    bucket         = "ejemplo-tfstate-brqx"
    key            = "ejemplo-app.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "ejemplo-tf-state-lock"
    # Necesario en anteriores versiones de Terraform
    # Usaremos variables de entorno
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
locals {
  prefix = "${var.prefix}-${terraform.workspace}"

  project_general = "ejemplo"

  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    Owner       = var.contact
    ManagedBy   = "Terraform-Brqx"
  }
}

## terraform workspace select staging