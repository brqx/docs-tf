# providers.tf
# ------------------------------------------------------------
# Exercise E000 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

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

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

