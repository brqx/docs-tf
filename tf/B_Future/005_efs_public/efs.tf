# ----------------------------------------------------------
# Info - 2022_Jul
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------

# EFS file system

locals {
  resource_name = "${local.prefix}-efs"
}

# ----------------------------------------------------------

resource "aws_efs_file_system" "shared_efs" {
  creation_token = local.resource_name

  lifecycle_policy {
    transition_to_ia = "AFTER_7_DAYS"
  }

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-a-efs" })
  )
}

# ----------------------------------------------------------

# EFS file system policy

resource "aws_efs_file_system_policy" "shared_efs" {
  file_system_id = aws_efs_file_system.shared_efs.id

  bypass_policy_lockout_safety_check = true

  policy = file("./policy/efs/efs.policy")

}

# ----------------------------------------------------------

# AWS EFS mount target

# EFS Security Group

resource "aws_security_group" "shared_efs" {
  name        = "${local.prefix}-efs-sg"
  description = "Allow EFS inbound traffic from VPC"
  vpc_id      = aws_vpc.main.id

  # Indicamos desd que vpc permitimos el acceso
  ingress {
    description      = "NFS traffic from VPC"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-a-efs-sg" })
  )
}

# ----------------------------------------------------------

# Relaciona EFS - Subnet - SG

resource "aws_efs_mount_target" "shared_fs" {
  file_system_id = aws_efs_file_system.shared_efs.id
  subnet_id      = aws_subnet.punlic["zone_a"].id
  security_groups = [ aws_security_group.shared_efs.id ]
}

