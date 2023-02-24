# ec2_sg.tf
# -----------------------------------------------------------
# Exercise E003 .. E00N
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_security_group
# ------------------------------------------------------------


resource "aws_security_group" "allow_ssh_and_http_sg" {
  name        = "allow_ssh_and_http_from_anywhere"
  description = "Allow BRQX SSH and HTTP inbound connections"

  vpc_id      = local.vpc_id

  # Vamos a intentar que acepte 60022
  ingress {
    from_port = 60022
    to_port   = 60022
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Vamos a intentar que acepte pings
  # Assuming you want to allow a ping (Echo) to your server you can use the following terraform configuration
  ingress {
    protocol  = "icmp"
    from_port = 8
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    # Pendiente para que solo llegu desde el ALB o R53
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permitimos que salga todo el trafico
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, tomap({ "Name" = "${local.prefix}-sg_ssh_and_http_from_anywhere" })
  )
}
