# ----------------------------------------------------------
# Info - 2022_Ago
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------

locals {
  ec2_file_system_local_mount_path = "/mnt/efs"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}


# EC2 demo instance

resource "aws_iam_policy_attachment" "ec2_role" {
  name       = "${local.prefix}-ec2-role"
  roles      = [ local.iam_ec2_role_name ]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_security_group" "amazon_linux_2" {
  name        = "${local.prefix}-amazon-linux-2"
  description = "Amazon Linux 2 SG"
  vpc_id      = local.vpc_id

  egress = [
    {
      description      = "ALL Traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]

  tags = merge(
    {
      Name = "${local.prefix}-amazon-linux-2"
    },
    local.common_tags
  )
}

resource "aws_network_interface" "amazon_linux_2" {
  subnet_id       = local.private_subnets[1]
  security_groups = [aws_security_group.amazon_linux_2.id]
}

resource "aws_iam_instance_profile" "amazon_linux_2" {
  name = "${local.prefix}-amazon-linux-2"
  role = local.iam_ec2_role_name
}

# ----------------------------------------------------------
# Remember connect
# ssh -i /path/key-pair-name.pem instance-user-name@instance-public-dns-name
# Connect EC2 MacOS
# eval $(ssh-agent)
# Agent pid 37582
# K mayuscula para macos
# ssh-add -K /Users/macminii7/farmacia2022_rsa.pem 

# Ref: https://www.howtogeek.com/devops/how-to-add-your-ec2-pem-file-to-your-ssh-keychain/

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  key_name                    = local.key
  subnet_id                   = aws_subnet.public["zone_a"].id
  vpc_security_group_ids      = [aws_security_group.allow_ssh_bastion.id]
  associate_public_ip_address = true

  user_data = file("./templates/bastion/user-data.sh")

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-bastion" })
  )

}

# ----------------------------------------------------------

resource "aws_security_group" "allow_ssh_bastion" {
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