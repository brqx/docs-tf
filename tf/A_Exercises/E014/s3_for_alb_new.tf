# s3_for_alb_new.tf
# ------------------------------------------------------------
# Exercise E014 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# Data TF Entities : 
# aws_s3_bucket - 
# ------------------------------------------------------------


# aws sts get-caller-identity --> check role is running correctly
# aws s3 cp <Fully Qualified Local filename> s3://<S3BucketName>

# A S3 bucket can be mounted in a AWS instance as a file system known as S3fs
# ACCOUNT_ID = data.aws_caller_identity.current.account_id

# ------------------------------------------------------------

resource "aws_s3_bucket" "newbucket" {
  bucket = "brqx-my-alb-tf-test-bucket-2023"
}

# ------------------------------------------------------------

resource "aws_s3_bucket_acl" "elb_logs_acl" {
  bucket = aws_s3_bucket.newbucket.id
  acl    = "private"
}

# ------------------------------------------------------------

data "aws_iam_policy_document" "allow_elb_logging" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.main.arn]
    }

    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.newbucket.arn}/AWSLogs/*"]
  }
}

# ------------------------------------------------------------

resource "aws_s3_bucket_policy" "allow_elb_logging" {
  bucket = aws_s3_bucket.newbucket.id
  policy = data.aws_iam_policy_document.allow_elb_logging.json
}

# Refs: 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elb_service_account.html