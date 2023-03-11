# alb_asg_policy_cpu.tf
# ------------------------------------------------------------
# Exercise E021 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_cloudwatch_metric_alarm
# aws_cloudwatch_composite_alarm
# ------------------------------------------------------------


# ------------------------------------------------------------

# CPUUtilization < 20 para 2 puntos de datos dentro de 2 minutos

# when we want to create custom alerts with mutliple metrics we can use math expressions

# Error
# creating CloudWatch Metric Alarm (web_cpu_alarm_down_a): ValidationError: 
# Exactly one element of the metrics list should return data.

resource "aws_cloudwatch_metric_alarm" "alarm_dw_query" {
  alarm_name = "web_cpu_alarm_down_a"
 
  comparison_operator = "LessThanThreshold"

  evaluation_periods = "2"

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = "60"

  threshold = "70"

  statistic = "Average"

  alarm_description = "Comprueba si se ha rebajado el 70% y superado el 3% de la CPU"  
  
  alarm_actions = [ "${aws_autoscaling_policy.dw.arn}"]

      # Son como filtros
  dimensions = {   AutoScalingGroupName = "${aws_autoscaling_group.main.name}"   }

}

# dimensions = (var.dimensions_value != null ? {
#    "${var.dimensions_name}" = "${var.dimensions_value}"
#  } : null)


# Refs : 
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Create_Composite_Alarm.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html#metric-math-syntax
