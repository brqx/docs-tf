# ----------------------------------------------------------
# Info - 2022_Ago
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------
# TF Ent: aws_instance - aws_security_group

# ----------------------------------------------------------

resource "aws_instance" "third_ec2" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  key_name                    = local.key
  subnet_id                   = aws_subnet.public["zone_a"].id
  vpc_security_group_ids      = [aws_security_group.allow_ssh_third.id]
  associate_public_ip_address = true

  user_data = file("./templates/bastion/user-data.sh")

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-third" })
  )

}

# ----------------------------------------------------------

resource "aws_security_group" "allow_ssh_third" {
  name        = "no_allow_ssh_to_private_zone"
  description = "Test not allow SSH from this instance to private zone"
  vpc_id      = aws_vpc.main.id

  # Vamos a intentar que acepte 60022
  ingress {
    from_port   = 60022
    to_port     = 60022
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-sg" })
  )
}