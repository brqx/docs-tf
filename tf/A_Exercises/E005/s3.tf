# s3.tf
# -----------------------------------------------------------
# Data
# aws_s3_bucket


# aws sts get-caller-identity --> check role is running correctly
# aws s3 cp <Fully Qualified Local filename> s3://<S3BucketName>

# A S3 bucket can be mounted in a AWS instance as a file system known as S3fs

data "aws_s3_bucket" "mybucket" {
  bucket = local.s3_bucket_name
}

