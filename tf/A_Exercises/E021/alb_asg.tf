# alb_asg.tf
# ------------------------------------------------------------
# Exercise E012 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_autoscaling_group
# ------------------------------------------------------------
# Nota : 
# - Grupo de escalado - Enlace a TG (zonas) y LC ( instancias )
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------


# Get User data
# http://169.254.169.254/latest/user-data

resource "aws_autoscaling_group" "main" {
  # Prefijo para las instancias
  name = "ec2-prueba-with-spot"

  min_size = local.min_instance

  # Se desactiva para poder aplicar politicas
  # desired_capacity = local.max_instance

  max_size = local.max_instance

  health_check_type = "ELB"

  # Enlace con TG
  target_group_arns = [aws_lb_target_group.main.arn]

  # Enlace con LC
  launch_configuration = aws_launch_configuration.main.name

  metrics_granularity = "1Minute"

  # Creo que es la de por defecto
  termination_policies = ["OldestInstance"]

  # Lista de subnets
  vpc_zone_identifier = [aws_subnet.public.id, aws_subnet.public_b.id]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  #  tags = merge(tomap({ "Name" = "${local.prefix}-alb-asg" }), local.common_tags)  

  # Esto no lo tengo claro
  tag {
    key                 = "Name"
    value               = local.resource_name
    propagate_at_launch = true
  }
}

# ejemplo para estresar las instancias
# sudo stress-ng --cpu 4 -v --timeout 3000s

# ------------------------------------------------------------


# Refs : 
# https://getbetterdevops.io/assign-static-ip-to-aws-load-balancers/#autoscaling-group 
# https://gist.github.com/ketzacoatl/be53b0d3bb286093648584fe32045665
# https://pet2cattle.com/2022/05/aws-network-load-balancer-autoscaling-group-terraform
