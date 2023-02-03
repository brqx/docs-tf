# s3_iam_role.tf
# ----------------------------------------------------------------
# Exercise E005
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_iam_policy - aws_iam_role
# aws_iam_role_policy_attachment
# aws_iam_instance_profile
# ----------------------------------------------------------------


# IAM Policy

resource "aws_iam_policy" "bucket_policy" {
  name        = "my-bucket-policy"
  path        = "/"
  description = "Allow "
  policy = data.template_file.s3_read_access_policy_template.rendered
}

# IAM Role

resource "aws_iam_role" "ec2_to_s3_access_role" {
  name = "ec2-to-s3-access"
  assume_role_policy = data.template_file.ec2_assume_role_template.rendered
  
}

# Iam Role - Policy Attachment

resource "aws_iam_role_policy_attachment" "ec2_s3_attachment" {
  role       = aws_iam_role.ec2_to_s3_access_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

# Iam Instance Profile
# Se relacxiona con el rol y es lo que vamos a usar para decirle a la instancia de EC2 que use este rol

resource "aws_iam_instance_profile" "ec2_access_to_s3" {
  name = "ec2-access-to-s3"
  role = aws_iam_role.ec2_to_s3_access_role.name
}