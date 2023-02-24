
# Get User data
# http://169.254.169.254/latest/user-data

resource "aws_instance" "amazon_linux_2" {
  ami           = data.aws_ami.amazon_linux_2_latest.id
  instance_type = local.ec2_instance_type
  
  key_name      = local.key_name
  subnet_id     = aws_subnet.private.id

  vpc_security_group_ids = [ aws_security_group.allow_ssh_and_http_sg.id ]

  # si no se pone se autoasocia una IP aunque no se llegue a ella
  associate_public_ip_address = false

  # AZ
  availability_zone = "${local.aws_region}a"

  user_data                   = data.template_file.ec2_shell_template.rendered
  user_data_replace_on_change = true

  tags = merge(tomap({ "Name" = "${local.prefix}-amazon-linux-2" }), local.common_tags)
}
