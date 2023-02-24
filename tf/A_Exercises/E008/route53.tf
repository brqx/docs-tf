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

# En el registro indicamos la IP publica o privada
# Ojo al TTL - 300 segundos 5 min
resource "aws_route53_record" "domain" {
  depends_on = [aws_instance.amazon_linux_2]    
  zone_id = data.aws_route53_zone.main.zone_id
  name    = data.aws_route53_zone.main.name
  type    = "A"
  ttl     = "30"
  records = [ aws_instance.amazon_linux_2.private_ip ]
  #records = [ aws_instance.amazon_linux_2.public_ip ]

}

resource "aws_route53_record" "www" {
  depends_on = [aws_instance.amazon_linux_2]    
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www.${data.aws_route53_zone.main.name}"
  type    = "A"
  ttl     = "30"
  records = [ aws_instance.amazon_linux_2.private_ip ]
  #records = [ aws_instance.amazon_linux_2.public_ip ]
}

# Si no tiene IP publica la EC2 y la indicamos aqui da este error :

# Error: creating Route 53 Record (Z08782082QMC46JWBY29W_www.DOMAIN_link_A): 
# updating record set: InvalidChangeBatch: [Invalid Resource Record: 
# FATAL problem: ARRDATAIllegalIPv4Address (Value is not a valid IPv4 address) encountered with ''']
#       status code: 400, request id: 194508b3-7e0e-442a-a9aa-61c27c6f0d20

# Refs:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone
