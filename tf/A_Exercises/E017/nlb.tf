# alb.tf
# ------------------------------------------------------------
# Exercise E011 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_lb - 
# ------------------------------------------------------------

# Create an Application Load Balancer

# creating application Load Balancer: 
# ValidationError: At least two subnets in two different Availability Zones must be specified
# 

# Error al acceder a los logs
# failure configuring LB attributes: InvalidConfigurationRequest: 
# Access Denied for bucket: fz3. Please check S3bucket permission
#│       status code: 400, request id: d9e26a54-7834-4934-b459-fa72e55314b7

resource "aws_lb" "test_alb" {
  name               = "test-alb"
  # Debe ser external, puesto que internal es que no sale fuera
  internal           = false
  load_balancer_type = "network"

  # creating network Load Balancer: 
  # InvalidConfigurationRequest: Security groups are not supported for load balancers with type 'network'

  subnets            = [ aws_subnet.public.id , aws_subnet.public_b.id ]

  enable_deletion_protection = false
  enable_http2               = false

#    prefix  = var.s3_alb_folder

  access_logs {
    bucket  = data.aws_s3_bucket.existent_bucket.id
    enabled = true
    # prefix  = "nlb/${var.name}-${var.environment}"
  }  
  tags = merge(tomap({ "Name" = "${local.prefix}-amazon-alb" }), local.common_tags)

}

# Refs :
# https://github.com/trussworks/terraform-aws-nlb-containers/blob/main/main.tf --> NLB Example

