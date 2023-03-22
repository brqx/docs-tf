# alb_asg_policy_cpu.tf
# ------------------------------------------------------------
# Exercise E021 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_autoscaling_policy
# ------------------------------------------------------------


# Get User data
# http://169.254.169.254/latest/user-data

# Stress
# sudo stress --cpu 4 -v --timeout 3000s

# Creating the autoscaling policy of the autoscaling group
resource "aws_autoscaling_policy" "up" {
  name = "autoscale_up_policy_ec2"

  # policy_type : tipo de política :  
  # "SimpleScaling"
  # "StepScaling" 
  # "TargetTrackingScaling"
  # Si no se proporciona este valor, AWS utilizará de forma predeterminada "SimpleScaling".
  policy_type = "TargetTrackingScaling"

  # The number of instances by which to scale.
  # cantidad de instancias por las que escalar. adjustment_type determina la interpretación de este número
  # Un incremento positivo se suma a la capacidad actual y un valor negativo se elimina de la capacidad actual.

  scaling_adjustment = 1

  # especifica si el ajuste es un número absoluto o un porcentaje de la capacidad actual. 
  # Los valores válidos son ChangeInCapacity , ExactCapacity y PercentChangeInCapacity .

  adjustment_type = "ChangeInCapacity"

  # la cantidad de tiempo (segundos) después de que se completa una actividad de escalado y antes de 
  # que pueda comenzar la siguiente actividad de escalado.

  # Tres minutos antes de que se ejecute de nuevo y pueda escalar otra instancia
  cooldown               = 180
  autoscaling_group_name = aws_autoscaling_group.main.name
}

