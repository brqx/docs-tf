# ami.tf
# -----------------------------------------------------------
# Exercise E003 .. E00N
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# Nota : 
# - Intancia de AMAZON - AMI - Imagen del servidor
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------


# Latest Amazon Linux 2 AMI

data "aws_ami" "amazon_linux_2_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}
