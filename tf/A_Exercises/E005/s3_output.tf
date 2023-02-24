# Fichero de salida E003 - output
#-------------------------------------


# Nuevos outputs del E005

output "s3_bucket" {
  value       = data.aws_s3_bucket.mybucket.id
  description = "Nombre del bucket S3 a usar"
}
