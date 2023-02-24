# variables.tf
# -----------------------------------------------------------
# Exercise E000 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

variable "prefix" {
  default     = "efs-terraform"
  description = "Common prefix for AWS resources names"
}

variable "aws_region" {
  default     = "eu-west-1"
  description = "AWS Region to deploy VPC"
}

# -----------------------------------------------------------
