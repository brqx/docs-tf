# alb_lc.tf
# ------------------------------------------------------------
# Exercise E012 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_launch_configuration
# ------------------------------------------------------------
# Nota : 
# - Definicion de los parametros de las instancias a generar
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------


# Get User data
# http://169.254.169.254/latest/user-data

# eval $(ssh-agent)
# ssh-add -k /Users/macminii7/farmacia2022_rsa.pem 

resource "aws_launch_configuration" "main" {
  name_prefix = local.resource_name

  image_id      = data.aws_ami.amazon_linux_2_latest.id
  instance_type = local.ec2_instance_type

  key_name = local.key_name

  #  availability_zone = "${local.aws_region}a"

  security_groups             = [aws_security_group.allow_ssh_and_http_sg.id]
  associate_public_ip_address = true
  user_data                   = data.template_file.ec2_shell_template.rendered

  # Prueba con instancias spot
  # ValidationError: Invalid bid price: 0.00001. Bid price must be greater than or equal to 0.001
  # Failed: Your Spot request price of 0.001 is lower than the minimum required Spot request fulfillment price of 0.005. Launching EC2 instance failed.
  spot_price = "0.005"

  lifecycle {
    create_before_destroy = true
  }

  # No permite tags
  # tags = merge(tomap({ "Name" = "${local.prefix}-alb-lc" }), local.common_tags)  
}
