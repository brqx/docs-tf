# alb_ls_ssl.tf
# ------------------------------------------------------------
# Link Exercise E013 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_lb_listener
# ------------------------------------------------------------
# Nota : 
# - Listener HTTPS
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------


# Create Application Load Balancer Listener for HTTPS
resource "aws_alb_listener" "linux-alb-listener-https" {
  depends_on = [
    aws_acm_certificate.route53_domain_certificate,
    aws_route53_record.route53_domain_validation,
    aws_acm_certificate_validation.domain_certificate_validation
  ]

  load_balancer_arn = aws_lb.test_alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.route53_domain_certificate.arn

  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = "forward"
  }
}

# Ref :
# https://github.com/KopiCloud/terraform-aws-ec2-internal-alb-acm-multi-account/blob/main/lb-main.tf
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule