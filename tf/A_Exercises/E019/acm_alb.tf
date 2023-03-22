# acm_alb.tf
# ------------------------------------------------------------
# File Exercise E019 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_acm_certificate
# aws_route53_record
# aws_acm_certificate_validation
# ------------------------------------------------------------
# Nota : 
# - Generacion y validacion de certificados en un dominio dado
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------

# Create Certificate
resource "aws_acm_certificate" "route53_domain_certificate" {
  domain_name               = var.domain_name
  subject_alternative_names = ["www.${var.domain_name}"]
  validation_method         = "DNS"

  # Esto no se bien si hace falta

  lifecycle { create_before_destroy = true }

  tags = merge(local.common_tags, tomap({ "Name" = "${local.prefix}-route53-certificate" }))
}

# ------------------------------------------------------------

# Create AWS Route 53 Certificate Validation Record in the Main Zone
resource "aws_route53_record" "route53_domain_validation" {

  for_each = {
    for dvo in aws_acm_certificate.route53_domain_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  # Entiendo que coge los del ultimo registro
  name    = each.value.name
  records = [each.value.record]
  type    = each.value.type

  # Valores genericos

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.main.zone_id
  ttl             = 60

}

# ------------------------------------------------------------

# Create Certificate Validation
resource "aws_acm_certificate_validation" "domain_certificate_validation" {

  certificate_arn         = aws_acm_certificate.route53_domain_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_domain_validation : record.fqdn]
}


# Refs:
# https://runebook.dev/es/docs/terraform/providers/aws/r/route53_record
# https://gist.github.com/sarkis/27672db85ab89189b7e430929c9376b0 --> Route53 records www Sarkis (old)
# https://stackoverflow.com/questions/63235321/aws-acm-certificate-seems-to-have-changed-its-state-output-possibly-due-to-a-pro

