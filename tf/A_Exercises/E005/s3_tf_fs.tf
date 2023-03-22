# s3_tf_fs.tf
# ----------------------------------------------------------------
# Exercise E005
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# Data 
# template_file
# ----------------------------------------------------------------

data "template_file" "s3_read_access_policy_template" {
  template = file("${local.tf_shell_path}policy/for_roles/s3/only_read_s3.policy")

  # Son variables que se interpolan cuando se interpreta el fichero
  vars = {
    SID = "${local.s3_sid_name}"
    BUCKET_NAME = "${local.s3_bucket_name}"
  }

}

# Template file for IAM Role

data "template_file" "ec2_assume_role_template" {
  template = file("${local.tf_shell_path}roles/assume_role_ec2.role")
}

