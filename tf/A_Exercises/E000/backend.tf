# backend.tf
# -----------------------------------------------------------
# Exercise E000 .. E00N
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# Bucket : brqx-terraform-remote-state-s3
# Key : amazon-exercises-terraform-a00-reuse.tfstate --> a00-reuse
# ------------------------------------------------------------
# Nota : 
# - Backend S3 - Dynamodb para guardar el estado ( util cuando se usan composiciones )
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------

terraform {
  backend "s3" {
    bucket         = "brqx-terraform-remote-state-s3"
    key            = "amazon-exercises-terraform-a01-reuse.tfstate"
    region         = "eu-west-1"
    encrypt        = "true"
    dynamodb_table = "brqx-terraform-remote-state-dynamodb"
  }
}
