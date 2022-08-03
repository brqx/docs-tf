
data "aws_region" "current" {}

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