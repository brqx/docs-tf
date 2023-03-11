# alb_lc.tf
# ------------------------------------------------------------
# Exercise E012 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_launch_configuration
# ------------------------------------------------------------

# Get User data
# http://169.254.169.254/latest/user-data

# Error - tiempo en el pasado
# reating Auto Scaling Scheduled Action (autoscalegroup_action): ValidationError: 
# Given start time is in the past

resource "aws_autoscaling_schedule" "mygroup_schedule" {
  scheduled_action_name  = "autoscalegroup_action"
# The minimum size for the Auto Scaling group
  min_size               = 1
# The maxmimum size for the Auto Scaling group
  max_size               = 5
# Desired_capacity is the number of running EC2 instances in the Autoscaling group
  desired_capacity       = 4
# defining the start_time of autoscaling if you think traffic can peak at this time.
# En irlanda es una hora menos
  start_time             = "2025-03-08T13:45:00Z"

  autoscaling_group_name = aws_autoscaling_group.main.name
}


# Refs : 
# https://pet2cattle.com/2022/05/aws-network-load-balancer-autoscaling-group-terraform