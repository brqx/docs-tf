# alb_ls.tf
# ------------------------------------------------------------
# Exercise E011 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_lb_listener
# ------------------------------------------------------------
# Nota : 
# - Listener HTTP
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------


# Create the Application Load Balancer Listener
resource "aws_lb_listener" "linux_alb_listener_http" {

  load_balancer_arn = aws_lb.test_alb.arn
  port              = 80
  protocol          = "HTTP"

  # Redirecion por defecto si no se cumplen las reglas
  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = "forward"
  }

  depends_on = [aws_lb.test_alb, aws_lb_target_group.main]

}


# REf
# https://registry.terraform.io/providers/hashicorp/aws/2.41.0/docs/resources/lb_listener_rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule