# alb_ls_rule.tf
# ------------------------------------------------------------
# Exercise E012 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_lb_listener
# 
# ------------------------------------------------------------


# De momento mandamos solo el trafico https
resource "aws_lb_listener_rule" "redirect_to_mobile_http" {
  listener_arn = "${aws_lb_listener.linux_alb_listener_http.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.second.arn
  }

  # Working
  condition {
    host_header {
      values = ["*.link"]
    }
  }
}


resource "aws_lb_listener_rule" "redirect_to_mobile_https" {
  listener_arn = "${aws_lb_listener.linux_alb_listener_https.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.second.arn
  }

  # For Iphone
  condition {
    http_header {
      http_header_name = "User-Agent"
      values = ["*phone*"]
    }
  }

}

# Error: creating LB Listener Rule: PriorityInUse: Priority '100' is currently in use

resource "aws_lb_listener_rule" "redirect_to_mobile_https_02" {
  listener_arn = "${aws_lb_listener.linux_alb_listener_https.arn}"
  priority     = 101

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.third.arn
  }

  # Android .. Este funciona
  condition {
    http_header {
      http_header_name = "User-Agent"
      values = ["*ndroid*"]
    }
  }

}



# Refs : 
# https://www.mariossimou.dev/blog/590aa0c4-47b9-4f24-be26-b12008bcc1ea --> Ful Example with Alb rules
# https://docs.aws.amazon.com/es_es/elasticloadbalancing/latest/application/x-forwarded-headers.html --> Aws Info X-Forwarded
# https://deviceatlas.com/device-detection --> Deteccion de dispositivos
# https://deviceatlas.com/blog/list-of-user-agent-strings
# https://exampleloadbalancer.com/advanced_request_routing_useragent_overview.html
# https://deviceatlas.com/blog/user-agent-string-analysis --> Analisis de User agent
# https://medium.datadriveninvestor.com/deep-dive-on-advanced-features-on-aws-application-load-balancer-and-network-load-balancer-49b05662e06 --> Deep dive Aws ALB

