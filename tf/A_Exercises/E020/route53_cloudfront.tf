# route53.tf
# ------------------------------------------------------------
# Exercise E011 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_route53_zone - 
# aws_route53_record
# ------------------------------------------------------------

data "aws_route53_zone" "main" {
  name         = var.domain_name
  # Debemos poner a false la zona privada
  # Tambien hay opcion de crear/gestionar zonas privadas accesibles solo desde dentro de Aws/Vpc
  private_zone = false
}

# ------------------------------------------------------------

resource "aws_route53_record" "cloudfront_rc" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  # El alias ( name ) es el nombre con el que amazon reconoce el ALB, lo que se conoce como el DNS_NAME
  # internal-test-alb-1187597157.eu-west-1.elb.amazonaws.com"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = true
  }
  depends_on = [ aws_cloudfront_distribution.main ]
}

# ------------------------------------------------------------

# creating Route 53 Record (): updating record set: InvalidChangeBatch: 
# [RRSet of type CNAME with DNS name www.zqx.link. is not permitted as it creates a CNAME or alias loop in the zone

resource "aws_route53_record" "www_cloudfront_rc" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.www_domain_name
  type    = "A"

  # El alias ( name ) es el nombre con el que amazon reconoce el ALB, lo que se conoce como el DNS_NAME
  # internal-test-alb-1187597157.eu-west-1.elb.amazonaws.com"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = true
  }
  depends_on = [ aws_cloudfront_distribution.main ]
}

# ------------------------------------------------------------


# Refs:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone
