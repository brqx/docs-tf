# efs.tf
# -----------------------------------------------------------
# Exercise E006 .. E00N
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_efs_access_point - aws_efs_mount_target
# -----------------------------------------------------------


# EFS Access Point - Imagino que se podra montar en lugar del VPC
# fsap-0fe35a29ad7eea36b.efs.eu-west-1.amazonaws.com:
resource "aws_efs_access_point" "drupal" {
  file_system_id = data.aws_efs_file_system.my_efs.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/drupal"
    creation_info {
      owner_gid   = 1000
      owner_uid   = var.uid_ec2_user
      permissions = 755
    }
  }

  tags = merge(tomap({ "Name" = "${local.prefix}-efs-access-point-drupal" }), local.common_tags)
}
