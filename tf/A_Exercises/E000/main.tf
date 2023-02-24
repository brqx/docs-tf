# main.tf
# -----------------------------------------------------------
# Exercise E000 .. E00N
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

# Region actual de Terraform
data "aws_region" "current" {}

locals {
  prefix          = "amazon-exercises-terraform"
  
  common_tags = {
    Environment = "dev"
    Project     = "RMB-TF-E001"
  }
}
