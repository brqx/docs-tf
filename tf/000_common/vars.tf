variable "region" {
  default = "eu-west-1"
}

variable "profile" {
  default = "k8"
}

variable "project_general" {
  default = "ejemplo"
}

variable "contact" {
  default = "aaa@bbb.ccc"
}

variable "project" {
  default = "tf-ejemplo-001"
}

variable "prefix" {
  default = "tf"
}


variable "keypair_name" {
  default = ""
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

