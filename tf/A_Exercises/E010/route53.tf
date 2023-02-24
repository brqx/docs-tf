# route53.tf
# ------------------------------------------------------------
# Exercise E001 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_route53_zone - 
# aws_route53_record
# ------------------------------------------------------------

data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "domain" {
  depends_on = [aws_instance.amazon_linux_2]    
  zone_id = data.aws_route53_zone.main.zone_id
  name    = data.aws_route53_zone.main.name
  type    = "A"
  ttl     = "300"
  records = [ aws_instance.amazon_linux_2.public_ip ]
}

resource "aws_route53_record" "www" {
  depends_on = [aws_instance.amazon_linux_2]    
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www.${data.aws_route53_zone.main.name}"
  type    = "A"
  ttl     = "300"
  records = [ aws_instance.amazon_linux_2.public_ip ]
}


# Refs:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone
