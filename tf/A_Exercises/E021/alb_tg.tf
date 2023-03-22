# alb.tf
# ------------------------------------------------------------
# Link Exercise E021 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_lb_target_group - 
# aws_alb_target_group_attachment
# aws_lb_listener
# 
# ------------------------------------------------------------

# Create a Load Balancer Target Group for HTTP
resource "aws_lb_target_group" "main" {
  name     = "alb-tg-http-main"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  deregistration_delay = 60
  stickiness {
    type = "lb_cookie"
  }
  health_check {
    path                = "/"
    port                = 80
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 10
    interval            = 30
    matcher             = "200,301,302"
  }
}

# ----------------------------------------------------------

