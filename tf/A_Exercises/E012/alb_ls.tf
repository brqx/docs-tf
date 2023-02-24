# alb_ls.tf
# ------------------------------------------------------------
# Exercise E012 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_lb_listener
# aws_lb_listener_rule
# 
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

  depends_on = [     aws_lb.test_alb ,  aws_lb_target_group.main   ]

}

# ----------------------------------------------------------
# Una regla para el listener. En principio es path_pattern pero tb se puede host_header

resource "aws_lb_listener_rule" "mobile_based_host" {
  listener_arn = aws_lb_listener.linux_alb_listener_http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  # Ojo que este formato ha cambiado
  # La idea es que acepte solo desktop por ejemplo
  condition {
    host_header {
     values = ["myservice.*.mobile.io"] 
    }
  #  field = "host-header"
  #  value = ["myservice.*.mobile.io"]
  }
}

#    path_pattern 
#      values = /forward_to/
#    

# REf
# https://registry.terraform.io/providers/hashicorp/aws/2.41.0/docs/resources/lb_listener_rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule