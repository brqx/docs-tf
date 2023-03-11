# s3_tf_fs.tf
# ----------------------------------------------------------------
# Exercise E014 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# Terraform Data : 
# template_file
# ----------------------------------------------------------------

data "template_file" "s3_read_access_policy_template" {
  template = file("${local.tf_shell_path}policy/only_read_s3.policy")

  # Son variables que se interpolan cuando se interpreta el fichero
  vars = {
    SID = "${var.s3_existent_sid_name}"
    BUCKET_NAME = "${var.s3_existent_bucket_name}"
  }

}

# ----------------------------------------------------------------

data "template_file" "s3_read_write_access_policy_template" {
  template = file("${local.tf_shell_path}policy/read_and_write_dual_s3.policy")

  # Son variables que se interpolan cuando se interpreta el fichero
  vars = {
    SID = "${var.s3_sid_name}"
    EXISTENT_SID = "${var.s3_existent_sid_name}"
    BUCKET_NAME = "${var.s3_bucket_name}"
    EXISTENT_BUCKET_NAME = "${var.s3_existent_bucket_name}"
  }

}

# ----------------------------------------------------------------

# Template file for IAM Role

data "template_file" "ec2_assume_role_template" {
  template = file("${local.tf_shell_path}roles/assume_role_ec2.role")
}

