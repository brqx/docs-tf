# clouidfront.tf
# ------------------------------------------------------------
# Exercise E011 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_lb_target_group - 
# aws_alb_target_group_attachment
# 
# ------------------------------------------------------------

# Route53 --> Cloudfront --> ALB 
# NOTA: Las distribuciones de CloudFront tardan unos 15 minutos en llegar al estado de implementación 
# después de la creación o modificación. 
# Durante este tiempo, se bloquearán las eliminaciones de recursos. 
# Si necesita eliminar una distribución  que está habilitada y no desea esperar
# debe usar el indicador retain_on_delete .

# Error : 
# Error: creating CloudFront Distribution: InvalidLocationCode: 
# Your request contains one or more invalid location codes.

# Error: creating CloudFront Distribution: InvalidViewerCertificate: 
#The specified SSL certificate doesn't exist, isn't in us-east-1 region, isn't valid, or doesn't include a valid certificate chain.

# Error insertando el www
# Error: updating CloudFront Distribution (E3LG0S7P1Z54WV): InvalidViewerCertificate: 
# The certificate that is attached to your distribution doesn't cover the alternate domain name (CNAME) 
# that you're trying to add.


resource "aws_cloudfront_distribution" "main" {
  
depends_on = [
    aws_acm_certificate.route53_cf_domain_certificate ,
    aws_route53_record.route53_cf_domain_validation ,
    aws_acm_certificate_validation.domain_cf_certificate_validation ,
    aws_lb.test_alb
  ]

  enabled             = true
  # Son los distintos alias a los que va a responder la distribución Cloudfront
  aliases             = [var.domain_name, var.www_domain_name]
  
  # Sin este parametro tarda mucho en eliminarse
  retain_on_delete    = false

  # Aqui hay que ver que es domain_name
  origin {
    domain_name = aws_lb.test_alb.dns_name
    origin_id   = aws_lb.test_alb.dns_name
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = aws_lb.test_alb.dns_name
    # Aqui indicamos que redireccione a https
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }
  # Creo que indica de donde pueden venir las restricciones
  restrictions {
    geo_restriction {
      # restriction_type = "none"
      restriction_type = "whitelist"
      locations        = ["IN", "US", "CA", "ES"]
    }
  }
  viewer_certificate {
##    cloudfront_default_certificate = true
    cloudfront_default_certificate = false

    acm_certificate_arn      = aws_acm_certificate.route53_cf_domain_certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

 tags = merge( local.common_tags, tomap({ "Name" = "${local.prefix}-cloudfront" })  )

}


# ----------------------------------------------------------

# Refs: 
# https://hands-on.cloud/cloudfront-terraform-examples/ --> Hands On Cloud - Cloudfront
# https://runebook.dev/es/docs/terraform/providers/aws/r/lb --> Terraform en Castellano
# https://github.com/tobilg/aws-edge-locations --> Aws Cloudfront Edge Locations
# https://runebook.dev/es/docs/terraform/providers/aws/r/cloudfront_distribution --> Tf Castellano
# https://medium.com/open-devops-academy/create-a-cloudfront-alert-with-terraform-aws-34c7ce294975 --> Medium Cloudfront
