# alb.tf
# ------------------------------------------------------------
# Exercise E011 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_lb_target_group - 
# aws_alb_target_group_attachment
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

# Attach EC2 Instances to Application Load Balancer Target Group

resource "aws_alb_target_group_attachment" "alb_tg_att_linux_2" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.amazon_linux_2.id
  port             = 80
}

# ----------------------------------------------------------

resource "aws_alb_target_group_attachment" "alb_tg_att_linux_1" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.amazon_linux_1.id
  port             = 80
}

# ----------------------------------------------------------

