# alb.tf
# ------------------------------------------------------------
# Exercise E011 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_lb - 
# ------------------------------------------------------------

# Create an Application Load Balancer


resource "aws_lb" "test_alb" {
  name               = "test-alb"
  # Debe ser external, puesto que internal es que no sale fuera
  internal           = false
  load_balancer_type = "application"

  security_groups    = [ aws_security_group.test_alb_sg.id ]
  subnets            = [ aws_subnet.public.id , aws_subnet.public_b.id ]

  # Acuerdate que los NLB lo tienen siempre activo
  # enable_cross_zone_load_balancing = true

  enable_deletion_protection = false
  enable_http2               = false

#    prefix  = var.s3_alb_folder

  tags = merge(tomap({ "Name" = "${local.prefix}-amazon-alb" }), local.common_tags)

}

# Refs :
# https://gmusumeci.medium.com/how-to-create-route-53-records-from-aws-cross-accounts-with-terraform-ef242528d606
# https://github.com/terraform-aws-modules/terraform-aws-alb/blob/master/main.tf
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule
# https://github.com/hands-on-cloud/managing-alb-using-terraform
# https://www.lewuathe.com/alb-listener-rule-with-terraform.html
# https://runebook.dev/es/docs/terraform/providers/aws/r/lb   --> Terraform en Esp
