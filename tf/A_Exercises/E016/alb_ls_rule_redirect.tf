# alb_ls_rule.tf
# ------------------------------------------------------------
# Exercise E012 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_lb_listener
# 
# ------------------------------------------------------------


# De momento mandamos solo el trafico https

# ------------------------------------------------------------
# Redirect to https example

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = "${aws_lb_listener.linux_alb_listener_http.arn}"
  priority = 15

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
     values = ["*.link"]
    }
  }
}

# ------------------------------------------------------------

# Redirect to S3 if mobile --> To test

resource "aws_lb_listener_rule" "redirect_to_image" {
  listener_arn = aws_lb_listener.linux_alb_listener_https.arn
  priority     = 10

  action {
    type = "redirect"

    # https://s3.eu-west-3.amazonaws.com/brqx.eu/doraemon_present_01.jpeg
    # La redireccion no funciona pues los sitios estaticos son sin SSL
    # Error: creating LB Listener Rule: InvalidLoadBalancerAction: 
    # The Path parameter must be a valid path, should start with a '/'
    # and may contain up to one of each of these placeholders: '#{path}', '#{host}', '#{port}'.  

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      host        = "s3.eu-west-3.amazonaws.com"
      path        = "/brqx.eu/doraemon_present_01.jpeg"
#      query       = "#{query}"
    }
  }

  # For Iphone
  condition {
    http_header {
      http_header_name = "User-Agent"
      values = ["*droid*"]
    }
    
  }
  # No se si es un and
  # Android .. Este funciona
  # condition {
  #  http_header {
  #    http_header_name = "User-Agent"
  #    values = ["*ndroid*"]
  #  }
  # }

}

# Health check example
# ------------------------------------------------------------

resource "aws_lb_listener_rule" "health_check" {
  listener_arn = "${aws_lb_listener.linux_alb_listener_https.arn}"

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "BRQX_ALB_HEALTHY"
      status_code  = "200"
    }
  }

  condition {
    path_pattern {
       values = ["/health"]
  }
  }
}


# Refs : 
# http://man.hubwiz.com/docset/Terraform.docset/Contents/Resources/Documents/docs/providers/aws/r/lb_listener_rule.html
