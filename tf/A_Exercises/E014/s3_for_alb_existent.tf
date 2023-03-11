# s3_for_alb_existent.tf
# ------------------------------------------------------------
# Exercise E011 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# Data TF Entities : 
# aws_s3_bucket - 
# aws_s3_bucket_acl
# aws_iam_policy_document
# aws_s3_bucket_policy
# ------------------------------------------------------------


# aws sts get-caller-identity --> check role is running correctly
# aws s3 cp <Fully Qualified Local filename> s3://<S3BucketName>

# A S3 bucket can be mounted in a AWS instance as a file system known as S3fs
# ACCOUNT_ID = data.aws_caller_identity.current.account_id


data "aws_s3_bucket" "existent_bucket" {
  bucket = var.s3_existent_bucket_name
}

# ------------------------------------------------------------

resource "aws_s3_bucket_acl" "existent_elb_logs_acl" {
  bucket = data.aws_s3_bucket.existent_bucket.id
  acl    = "private"
}

# ------------------------------------------------------------

data "aws_iam_policy_document" "existent_allow_elb_logging" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.main.arn]
    }

    actions   = ["s3:PutObject"]
    resources = ["${data.aws_s3_bucket.existent_bucket.arn}/AWSLogs/*"]
  }
}

# ------------------------------------------------------------

# Relaciona el Bucket con la politica

resource "aws_s3_bucket_policy" "existent_allow_elb_logging" {
  bucket = data.aws_s3_bucket.existent_bucket.id
  policy = data.aws_iam_policy_document.existent_allow_elb_logging.json
}

# Refs: 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elb_service_account.html