# ec2_sg.tf
# -----------------------------------------------------------
# Exercise E003 .. E00N

# TF Entities : 
# aws_security_group


resource "aws_security_group" "allow_ssh_and_http_sg" {
  name        = "allow_ssh_and_http_from_anywhere"
  description = "Allow BRQX SSH and HTTP inbound connections"

  vpc_id      = local.vpc_id

  # Vamos a intentar que acepte 60022
  ingress {
    from_port = 60022
    to_port   = 60022
    protocol  = "tcp"
    # Pendiente para que solo llegu desde el ALB o R53
    #security_groups = [aws_security_group.allow_ssh_from_alb.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    # Pendiente para que solo llegu desde el ALB o R53
    #security_groups = [aws_security_group.allow_ssh_from_alb.id]
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
