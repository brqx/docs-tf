# ----------------------------------------------------------
# Info - 2022_Jul
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------


terraform {
  backend "s3" {
    # Aqui no se permiten variables
    bucket         = "ejemplo-tfstate-brqx"
    key            = "efs-terraform-app.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "ejemplo-tf-state-lock"
    # Necesario en anteriores versiones de Terraform
    # Usaremos variables de entorno
  }
}


## terraform workspace select staging