terraform {
  backend "s3" {
    bucket         = "${var.project_general}-tfstate-brqx"
    key            = "${var.project_general}-app.tfstate"
    region         = var.region
    encrypt        = true
    dynamodb_table = "${var.project_general}-tf-state-lock"
    # Necesario en anteriores versiones de Terraform
    # Usaremos variables de entorno
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

# El prefijo va a informar del proyecto relacionado con el recurso
# Ej : raad-dev
# Recipe App Api Devops
locals {
  prefix = "${var.prefix}-${terraform.workspace}"
}

locals {
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    Owner       = var.contact
    ManagedBy   = "Terraform-Brqx"
  }
}