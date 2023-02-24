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
resource "aws_lb" "test_alb" {
  name               = "test-alb"
  # Debe ser external, puesto que internal es que no sale fuera
  # external --> resuelve ips publicas
  
  internal           = false
  # internal           = true
  load_balancer_type = "application"

  security_groups    = [ aws_security_group.alb_sg_full.id ]
  subnets            = [ aws_subnet.public.id , aws_subnet.public_b.id ]

  enable_deletion_protection = false
  enable_http2               = false
  
  tags = merge(tomap({ "Name" = "${local.prefix}-amazon-alb" }), local.common_tags)

}

# Refs :
# https://gmusumeci.medium.com/how-to-create-route-53-records-from-aws-cross-accounts-with-terraform-ef242528d606
# https://github.com/terraform-aws-modules/terraform-aws-alb/blob/master/main.tf
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule
# https://github.com/hands-on-cloud/managing-alb-using-terraform
# https://www.lewuathe.com/alb-listener-rule-with-terraform.html
# https://runebook.dev/es/docs/terraform/providers/aws/r/lb   --> Terraform en Esp
