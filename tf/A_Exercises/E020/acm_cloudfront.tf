# acm.tf
# ------------------------------------------------------------
# Exercise E010 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_acm_certificate
# aws_route53_record
# aws_acm_certificate_validation
# ------------------------------------------------------------

# Create Certificate
resource "aws_acm_certificate" "route53_cf_domain_certificate" {
  provider = aws.us-east-1
  domain_name       = "${var.domain_name}"
  subject_alternative_names = ["www.${var.domain_name}"]  
  validation_method = "DNS"
  
  tags = merge( local.common_tags, tomap({ "Name" = "${local.prefix}-route53-certificate" })  )
}

# Este es el formato largo. Con el bucle se incluyen todos lo registros ( incluidos www )
# resource "aws_route53_record" "www_route53_domain_validation" {
#   name    = "${aws_acm_certificate.route53_domain_certificate.domain_validation_options.1.resource_record_name}"
#   type    = "${aws_acm_certificate.route53_domain_certificate.domain_validation_options.1.resource_record_type}"
#   records = ["${aws_acm_certificate.route53_domain_certificate.domain_validation_options.1.resource_record_value}"]

#   zone_id = "${data.aws_route53_zone.route53_domain_certificate.zone_id}"
#   ttl     = "60"
# }

# Create AWS Route 53 Certificate Validation Record in the Main Zone
resource "aws_route53_record" "route53_cf_domain_validation" {

  for_each = {
    for dvo in aws_acm_certificate.route53_cf_domain_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  # Entiendo que coge los del ultimo registro
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type

  # Valores genericos
  provider = aws.us-east-1

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.main.zone_id
  ttl             = 60
  
}

# Validacion sin bucles
# resource "aws_acm_certificate_validation" "example_com" {
#   certificate_arn         = "${aws_acm_certificate.example_com.arn}"
#   validation_record_fqdns = ["${aws_route53_record.example_com_acm_verification.fqdn}", 
#                              "${aws_route53_record.www_example_com_acm_verification.fqdn}"]
# }


# Create Certificate Validation
resource "aws_acm_certificate_validation" "domain_cf_certificate_validation" {
  provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.route53_cf_domain_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_cf_domain_validation : record.fqdn]
}


# Refs:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation
# https://runebook.dev/es/docs/terraform/providers/aws/r/route53_record
# https://gist.github.com/sarkis/27672db85ab89189b7e430929c9376b0
# Clouidfront ACM Certificates in US-EAST-1
# https://stackoverflow.com/questions/59950775/error-creating-cloudfront-distribution-with-terraform-invalidviewercertificate
# https://stackoverflow.com/questions/51988417/terraform-aws-acm-certificates-in-us-east-1-for-resources-in-eu-west-1

