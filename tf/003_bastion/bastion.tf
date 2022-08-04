# ----------------------------------------------------------
# Info - 2022_Ago
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

# ----------------------------------------------------------
# Remember connect
# ssh -i /path/key-pair-name.pem instance-user-name@instance-public-dns-name
# Connect EC2 MacOS
# eval $(ssh-agent)
# Agent pid 37582
# ssh-add -k /Users/macminii7/farmacia2022_rsa.pem 

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  key_name                    = local.key
  subnet_id                   = aws_subnet.public["zone_a"].id
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  associate_public_ip_address = true

  user_data = file("./templates/bastion/user-data.sh")

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-bastion" })
  )

}

# ----------------------------------------------------------

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_sg"
  description = "Allow BRQX SSH inbound connections"
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