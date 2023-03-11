# alb_lc.tf
# ------------------------------------------------------------
# Exercise E012 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_launch_configuration
# ------------------------------------------------------------


# Get User data
# http://169.254.169.254/latest/user-data

# eval $(ssh-agent)
# ssh-add -k /Users/macminii7/farmacia2022_rsa.pem 

resource "aws_launch_configuration" "main" {
  name_prefix = local.resource_name

  image_id      = data.aws_ami.amazon_linux_2_latest.id 
  instance_type = local.ec2_instance_type

  key_name      = local.key_name

#  availability_zone = "${local.aws_region}a"

  security_groups             = [aws_security_group.allow_ssh_and_http_sg.id]
  associate_public_ip_address = true
  user_data                   = data.template_file.ec2_shell_template.rendered

  lifecycle {
    create_before_destroy = true
  }

  # No permite tags
  # tags = merge(tomap({ "Name" = "${local.prefix}-alb-lc" }), local.common_tags)  
}
