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

resource "aws_route53_record" "alb_rc" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  # El alias ( name ) es el nombre con el que amazon reconoce el ALB, lo que se conoce como el DNS_NAME
  # internal-test-alb-1187597157.eu-west-1.elb.amazonaws.com"

  alias {
    name                   = aws_lb.test_alb.dns_name
    zone_id                = aws_lb.test_alb.zone_id
    evaluate_target_health = true
  }
  depends_on = [ aws_lb.test_alb ]
}

# Refs:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone
