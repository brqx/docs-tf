# Variables de la conexion
variable "region" {
  default = "eu-west-1"
}

variable "profile" {
  default = "k8"
}

# Variables del proyecto

variable "project_general" {
  description = "Nombre del proyecto general"
  default = "ejemplo"
}

variable "contact" {
  default = "aaa@bbb.ccc"
}

variable "project" {
  description = "Nombre del proyecto especifico"
  default = "tf-ejemplo-001"
}

variable "prefix" {
  description = "Prefijo para definir el proyecto"
  default = "tf"
}


variable "keypair_name" {
  default = ""
}

# Variables para la Red

variable "vpc_cidr" {
  description = "AWS VPC CIDR range"
  default     = "30.1.0.0/16"
}

variable "vpc_cidr_blocks" {
  description = "AWS VPC CIDR blocks number for subnets"
  default     = "8"  # 8 bits /24
}

# Variables para Base de datos
variable "db_username" {
  description = "Username for the RDS Postgres instance"
  default     = ""
}

variable "db_password" {
  description = "Password for the RDS postgres instance"
  default     = ""
}

variable "sqlfile" {
  description = "Script que se pasa a la base de datos"
  default     = "./resources/db/palillos_2022.sql"
}

