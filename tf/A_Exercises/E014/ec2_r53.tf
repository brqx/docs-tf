
# Get User data
# http://169.254.169.254/latest/user-data

resource "aws_instance" "amazon_linux_2" {
  ami           = data.aws_ami.amazon_linux_2_latest.id
  instance_type = local.ec2_instance_type
  
  key_name      = local.key_name
  subnet_id     = aws_subnet.public.id


  vpc_security_group_ids = [ aws_security_group.allow_ssh_and_http_sg.id ]

  # AZ
  availability_zone = "${local.aws_region}a"

  # Instance Profile to access to S3
  iam_instance_profile = aws_iam_instance_profile.ec2_access_to_s3.name

  user_data                   = data.template_file.ec2_shell_template.rendered
  user_data_replace_on_change = true

  tags = merge(tomap({ "Name" = "${local.prefix}-amazon-linux-2" }), local.common_tags)
}

resource "aws_instance" "amazon_linux_1" {
  ami           = data.aws_ami.amazon_linux_2_latest.id
  instance_type = local.ec2_instance_type
  
  key_name      = local.key_name
  subnet_id     = aws_subnet.public_b.id


  vpc_security_group_ids = [ aws_security_group.allow_ssh_and_http_sg.id ]

  # AZ
  availability_zone = "${local.aws_region}b"

  # Instance Profile to access to S3
  iam_instance_profile = aws_iam_instance_profile.ec2_access_to_s3.name

  user_data                   = data.template_file.ec2_shell_template.rendered
  user_data_replace_on_change = true

  tags = merge(tomap({ "Name" = "${local.prefix}-amazon-linux-1" }), local.common_tags)
}
