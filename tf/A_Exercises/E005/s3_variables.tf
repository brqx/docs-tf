# 1_vpc - variables_s3.tf
# -----------------------------------------------------------
# Exercise E005


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


# -----------------------------------------------------------
