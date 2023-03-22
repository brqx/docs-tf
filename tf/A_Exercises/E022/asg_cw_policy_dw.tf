# alb_asg_policy_cpu.tf
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

resource "aws_autoscaling_policy" "dw" {
  name = "autoscale_policy_dw_ec2"

  policy_type = "TargetTrackingScaling"

  # policy_type : (opcional) el tipo de política, ya sea 
  # "SimpleScaling", "StepScaling" o "TargetTrackingScaling". 
  # Si no se proporciona este valor, AWS utilizará de forma predeterminada "SimpleScaling".

  scaling_adjustment = -1

  # especifica si el ajuste es un número absoluto o un porcentaje de la capacidad actual. 
  # Los valores válidos son ChangeInCapacity , ExactCapacity y PercentChangeInCapacity .

  adjustment_type = "ChangeInCapacity"

  # Para desescalar mas rapido ... 30 segundos  
  cooldown               = 30
  autoscaling_group_name = aws_autoscaling_group.main.name
}

# ------------------------------------------------------------

