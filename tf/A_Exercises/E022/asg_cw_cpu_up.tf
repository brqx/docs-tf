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

# ------------------------------------------------------------

# CPUUtilization > 70 para 2 puntos de datos dentro de 2 minutos

resource "aws_cloudwatch_metric_alarm" "metric_up" {
  # defining the name of AWS cloudwatch alarm
  alarm_name = "web_cpu_alarm_up"

  comparison_operator = "GreaterThanThreshold"

  # Define el periodo sobre el que se actua ( 5 puntos de datos dentro de 5 minutos )
  evaluation_periods = "2"
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
  alarm_actions = ["${aws_autoscaling_policy.up.arn}", "${aws_sns_topic.prueba.arn}"]

  # "${aws_autoscaling_policy.up.arn}"
  # Special Arn to reboot
  # Example to reboot instance arn:aws:automate:${data.aws_region.current.name}:ec2:reboot

  dimensions = { AutoScalingGroupName = "${aws_autoscaling_group.main.name}" }
}




# Refs : 
# https://getbetterdevops.io/assign-static-ip-to-aws-load-balancers/#autoscaling-group 
# https://gist.github.com/ketzacoatl/be53b0d3bb286093648584fe32045665
# https://pet2cattle.com/2022/05/aws-network-load-balancer-autoscaling-group-terraform