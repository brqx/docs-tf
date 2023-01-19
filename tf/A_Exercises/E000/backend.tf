# 1_vpc - Backend S3
# Bucket : brqx-terraform-remote-state-s3
# Key : amazon-exercises-terraform-a00-reuse.tfstate --> a00-reuse
terraform {
  backend "s3" {
    bucket         = "brqx-terraform-remote-state-s3"
    key            = "amazon-exercises-terraform-a01-reuse.tfstate"
    region         = "eu-west-1"
    encrypt        = "true"
    dynamodb_table = "brqx-terraform-remote-state-dynamodb"
  }
}
