# asg_cw_cpu_dw.tf
# ------------------------------------------------------------
# Exercise E021 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_cloudwatch_metric_alarm
# aws_autoscaling_policy
# ------------------------------------------------------------

# Get User data
# http://169.254.169.254/latest/user-data

# Stress
# sudo stress-ng --cpu 4 -v --timeout 3000s

# Date Starttime
# date "+%Y-%m-%dT%H:%M:%SZ"

# EL nombre de las politicas es muy importante y es lo que se usa cuando se actua con ellas

resource "aws_autoscaling_policy" "dw" {
  name                   = "policy_scale_down"

# policy_type : (opcional) el tipo de política, ya sea 
# "SimpleScaling", "StepScaling" o "TargetTrackingScaling". 
# Si no se proporciona este valor, AWS utilizará de forma predeterminada "SimpleScaling".

  scaling_adjustment     = -1

# especifica si el ajuste es un número absoluto o un porcentaje de la capacidad actual. 
# Los valores válidos son ChangeInCapacity , ExactCapacity y PercentChangeInCapacity .
  
  adjustment_type        = "ChangeInCapacity"

  # Para desescalar mas rapido ... 30 segundos  
  cooldown               = 30
  autoscaling_group_name = aws_autoscaling_group.main.name
}

# ------------------------------------------------------------

# CPUUtilization < 20 para 2 puntos de datos dentro de 2 minutos

resource "aws_cloudwatch_metric_alarm" "alarm_dw" {
# defining the name of AWS cloudwatch alarm
  alarm_name = "web_cpu_alarm_down"

# comparison_operator : operación que se utilizará al comparar la Estadística y el Umbral especificados
# El valor estadístico especificado se utiliza como primer operando
# Cualquiera de los siguientes es compatible: 
# GreaterThanOrEqualToThreshold , GreaterThanThreshold , LessThanThreshold , LessThanOrEqualToThreshold .

  comparison_operator = "LessThanThreshold"
 
# El número de períodos durante los cuales los datos se comparan con el umbral especificado.
# Esto no lo tengo claro
  evaluation_periods = "2"

# Defining the metric_name according to which scaling will happen (based on CPU) 
# Parece que es la media de todas las instancias
  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  # After AWS Cloudwatch Alarm is triggered, it will wait for 60 seconds and then autoscales
  # El período en segundos durante el cualse aplica la statistic especificada.

  # Debe ser 60. Es decir aplicamos cada minuto
  period = "60"

 # estadística que se aplicará a la métrica asociada a la alarma
 # Se admite cualquiera de los siguientes: SampleCount , Average , Sum , Minimum , Maximum
  statistic = "Average"
# CPU Utilization threshold is set to 10 percent
  threshold = "${local.threshold_down}"
  
  alarm_description = "Comprueba si estamos por debajo del umbral del 70% de la CPU"  

  # Necesitamos una politica de autoscaling
  alarm_actions = [  "${aws_autoscaling_policy.dw.arn}"     ]

  dimensions = {   AutoScalingGroupName = "${aws_autoscaling_group.main.name}"   }
}


# Refs : 
# https://getbetterdevops.io/assign-static-ip-to-aws-load-balancers/#autoscaling-group 
# https://gist.github.com/ketzacoatl/be53b0d3bb286093648584fe32045665
# https://pet2cattle.com/2022/05/aws-network-load-balancer-autoscaling-group-terraform