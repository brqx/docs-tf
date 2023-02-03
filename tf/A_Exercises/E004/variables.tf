# variables.tf
# -----------------------------------------------------------
# Exercise E001

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


# Variables para S3

variable "s3_bucket_name" {
  description = "Nombre del Bucket S3 a usar"
  default     = "fz3"
}

# Statement IDs (SID) must be alpha-numeric
variable "s3_sid_name" {
  description = "Nombre del SID para el Bucket S3 a usar"
  default     = "fz3sid"
}

# Folder a recuperar
variable "s3_folder" {
  description = "Folder a recuperar en el bucket de S3"
  default     = "test"
}

# Fichero a recuperar
variable "s3_file" {
  description = "Nombre del SID para el Bucket S3 a usar"
  default     = "file_file_from_s3.dat"
}

