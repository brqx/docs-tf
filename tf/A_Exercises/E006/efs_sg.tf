# EFS Security Group

resource "aws_security_group" "efs_sg" {
  name        = "${local.prefix}-efs-sg"
  description = "Allow EFS inbound traffic from VPC"
  vpc_id      = aws_vpc.main.id

  # Indicamos los security groups que permitimos entrada 
  ingress {
    security_groups = [aws_security_group.allow_ssh_and_http_sg.id]
    description = "NFS traffic from VPC"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    # Este rango puede ser el de cada subred para mas seguridad
    #cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
     security_groups = [aws_security_group.allow_ssh_and_http_sg.id]
     from_port = 0
     to_port = 0
     protocol = "-1"
   }

  tags = merge(tomap({ "Name" = "${local.prefix}-efs-sg" }), local.common_tags)
}
