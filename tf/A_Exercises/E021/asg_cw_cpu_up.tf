# alb_asg_policy_cpu.tf
# ------------------------------------------------------------
# Exercise E021 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_cloudwatch_metric_alarm
# ------------------------------------------------------------


# Get User data
# http://169.254.169.254/latest/user-data

# Stress
# sudo stress --cpu 4 -v --timeout 3000s

# Creating the autoscaling policy of the autoscaling group
resource "aws_autoscaling_policy" "up" {
  name                   = "autoscalegroup_policy"

# policy_type : tipo de política :  
# "SimpleScaling"
# "StepScaling" 
# "TargetTrackingScaling"
# Si no se proporciona este valor, AWS utilizará de forma predeterminada "SimpleScaling".

# The number of instances by which to scale.
# cantidad de instancias por las que escalar. adjustment_type determina la interpretación de este número
# Un incremento positivo se suma a la capacidad actual y un valor negativo se elimina de la capacidad actual.

  scaling_adjustment     = 1

# especifica si el ajuste es un número absoluto o un porcentaje de la capacidad actual. 
# Los valores válidos son ChangeInCapacity , ExactCapacity y PercentChangeInCapacity .
  
  adjustment_type        = "ChangeInCapacity"
  
# la cantidad de tiempo (segundos) después de que se completa una actividad de escalado y antes de 
# que pueda comenzar la siguiente actividad de escalado.
  
  # Tres minutos antes de que se ejecute de nuevo y pueda escalar otra instancia
  cooldown               = 180
  autoscaling_group_name = aws_autoscaling_group.main.name
}

# ------------------------------------------------------------

# CPUUtilization > 70 para 2 puntos de datos dentro de 2 minutos
#	CPUUtilization > 70 para 5 puntos de datos dentro de 5 minutos

resource "aws_cloudwatch_metric_alarm" "metric_up" {
# defining the name of AWS cloudwatch alarm
  alarm_name = "web_cpu_alarm_up"
  comparison_operator = "GreaterThanThreshold"
  
  # Define el periodo sobre el que se actua ( 5 puntos de datos dentro de 5 minutos )
  evaluation_periods = "5"
# Defining the metric_name according to which scaling will happen (based on CPU) 
  metric_name = "CPUUtilization"
# The namespace for the alarm's associated metric
  namespace = "AWS/EC2"
# After AWS Cloudwatch Alarm is triggered, it will wait for 60 seconds and then autoscales

  # El período en segundos durante el cual se aplica la estatistica especificada
  # Creo que es cada 60 segundos
  period = "60"

  statistic = "Average"
# CPU Utilization threshold is set to 70 percent
  threshold = "70"

  alarm_description = "Comprueba si se ha superado el 70% de la CPU"  
  
  # Necesitamos una politica de autoscaling
  alarm_actions = [  "${aws_autoscaling_policy.up.arn}"     ]
  dimensions = {   AutoScalingGroupName = "${aws_autoscaling_group.main.name}"   }
}




# Refs : 
# https://getbetterdevops.io/assign-static-ip-to-aws-load-balancers/#autoscaling-group 
# https://gist.github.com/ketzacoatl/be53b0d3bb286093648584fe32045665
# https://pet2cattle.com/2022/05/aws-network-load-balancer-autoscaling-group-terraform