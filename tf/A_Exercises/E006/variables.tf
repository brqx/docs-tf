# variables.tf
# -----------------------------------------------------------
# Exercise E006

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

# Nuevas variables E001

variable "keys_folder" {
  description = "Ruta para las claves aws. Nunca se sube a github"
  default     = "/Library/tf/keys/"
}

variable "project_path" {
  description = "Ruta para los ficheros de politica y shell de los proyectos"
  default     = "/Library/tf/docs/docs-tf/"
}

variable "ssh_secret_port" {
  description = "Puerto SSH secreto para las instancias EC2 y para los contenedores de Fargate"
  default     = "60022"
}

variable "uid_ec2_user" {
  description = "UID para el usuario a montar en file system de s3"
  default     = "1000"
}


# Variables para EFS

variable "efs_id" {
  description = "ID del File System EFS a usar"
  default     = "fs-05b99badf944e77c6"
}

variable "efs_folder" {
  description = "Folder donde montar el Sistema EFS o el Punto de Acceso"
  default     = "/drupal"
}

variable "efs_file" {
  description = "Fichero que se recupera desde EFS Punto de Acceso"
  default     = "example.txt"
}

# -----------------------------------------------------------
