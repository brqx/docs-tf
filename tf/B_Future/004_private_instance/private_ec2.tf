# ----------------------------------------------------------
# Info - 2022_Ago
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------

# ----------------------------------------------------------

# Remember : connect to private ( Agent )
# aw2sa 54.216.112.138
# Ref: https://digitalcloud.training/ssh-into-ec2-in-private-subnet/

resource "aws_instance" "private_ec2" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  key_name                    = local.key
  subnet_id                   = aws_subnet.private["zone_a"].id
  vpc_security_group_ids      = [aws_security_group.allow_ssh_only_from_bastion.id]
  associate_public_ip_address = false

  user_data = file("./templates/bastion/user-data.sh")

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-private-ec2" })
  )

}

# ----------------------------------------------------------

resource "aws_security_group" "allow_ssh_only_from_bastion" {
  name        = "allow_ssh__only_from_bastion"
  description = "Allow BRQX SSH inbound connections"
  vpc_id      = aws_vpc.main.id

  # Vamos a intentar que acepte 60022
  ingress {
    from_port       = 60022
    to_port         = 60022
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_ssh_bastion.id]
    #cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-sg_only_from_bastion" })
  )
}