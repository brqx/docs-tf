# 1_vpc - variables.tf

variable "prefix" {
  default     = "efs-terraform"
  description = "Common prefix for AWS resources names"
}

variable "aws_region" {
  default     = "eu-west-1"
  description = "AWS Region to deploy VPC"
}

variable "vpc_cidr" {
  default     = "10.20.0.0/16"
  description = "AWS VPC CIDR range"
}

variable "vpc_cidr_blocks" {
  description = "AWS VPC CIDR blocks number for subnets"
  default     = "8" # 8 bits /24
}