# route53_www_alb.tf
# ------------------------------------------------------------
# Exercise E019 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_route53_record
# ------------------------------------------------------------

# ------------------------------------------------------------

# Error mix A and CNAME
# Error: creating Route 53 Record (): updating record set: InvalidChangeBatch: 
# [RRSet of type CNAME with DNS name www.zqx.link. is not permitted as it conflicts with other records with the same DNS name in zone zqx.link., RRSet of type CNAME with DNS name www.zqx.link. 
# is not permitted as it creates a CNAME or alias loop in the zone.

# No funciona. Vamos a intentar crearlo con la consola

# resource "aws_route53_record" "www_dev" {
#   zone_id = data.aws_route53_zone.main.zone_id
#   name    = var.www_domain_name
#   type    = "CNAME"
#   ttl     = 5

#   weighted_routing_policy {
#     weight = 10
#  }

#  set_identifier = "www"
#   records        = ["${var.www_domain_name}"]
# }

resource "aws_route53_record" "www_alb_rc" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  # El alias ( name ) es el nombre con el que amazon reconoce el ALB, lo que se conoce como el DNS_NAME
  # internal-test-alb-1187597157.eu-west-1.elb.amazonaws.com"

  alias {
    name                   = aws_lb.test_alb.dns_name
    zone_id                = aws_lb.test_alb.zone_id
    evaluate_target_health = true
  }
  depends_on = [ aws_lb.test_alb, aws_route53_record.alb_rc ]
}


# Refs:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone
