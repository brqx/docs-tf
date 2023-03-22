# s3_full.tf
# ------------------------------------------------------------
# Exercise E004 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# Run S3 commands from ec2
#
# aws sts get-caller-identity --> check role is running correctly
# aws s3 cp <Fully Qualified Local filename> s3://<S3BucketName>

# A S3 bucket can be mounted in a AWS instance as a file system known as S3fs

data "aws_s3_bucket" "mybucket" {
  bucket = local.s3_bucket_name
}

# ------------------------------------------------------------

# Template file for IAM Policy

data "template_file" "s3_read_access_policy_template" {
  template = file("${local.tf_shell_path}policy/for_roles/s3/only_read_s3.policy")

  # Son variables que se interpolan cuando se interpreta el fichero
  vars = {
    SID = "${local.s3_sid_name}"
    BUCKET_NAME = "${local.s3_bucket_name}"
  }

}

# ------------------------------------------------------------

# Template file for IAM Role

data "template_file" "ec2_assume_role_template" {
  template = file("${local.tf_shell_path}roles/assume_role_ec2.role")
}

# ------------------------------------------------------------

# IAM Policy

resource "aws_iam_policy" "bucket_policy" {
  name        = "my-bucket-policy"
  path        = "/"
  description = "Allow "
  policy = data.template_file.s3_read_access_policy_template.rendered
}

# ------------------------------------------------------------

# IAM Role

resource "aws_iam_role" "ec2_to_s3_access_role" {
  name = "ec2-to-s3-access"
  assume_role_policy = data.template_file.ec2_assume_role_template.rendered
  
}

# ------------------------------------------------------------

# Iam Role - Policy Attachment

resource "aws_iam_role_policy_attachment" "ec2_s3_attachment" {
  role       = aws_iam_role.ec2_to_s3_access_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

# ------------------------------------------------------------

# Iam Instance Profile

resource "aws_iam_instance_profile" "ec2_access_to_s3" {
  name = "ec2-access-to-s3"
  role = aws_iam_role.ec2_to_s3_access_role.name
}