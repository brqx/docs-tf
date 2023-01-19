# ----------------------------------------------------------
# Info - 2022_Jul
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------

# EFS access points

resource "aws_efs_access_point" "lambda" {
  file_system_id = aws_efs_file_system.shared_efs.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/lambda"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = 755
    }
  }

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-a-efs-access-lambda" })
  )
}

resource "aws_efs_access_point" "fargate" {
  file_system_id = aws_efs_file_system.shared_efs.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/fargate"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = 755
    }
  }

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-a-efs-access-fargate" })
  )
}