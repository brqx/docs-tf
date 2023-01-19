# 1_vpc - providers.tf

# Set up Terraform provider version (if required)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.9"
    }
    random = {
      source  = "hashicorp/random"
      version = "2.3.0"
    }
  }
}

# Defining AWS provider
provider "aws" {
  region = var.aws_region
}
