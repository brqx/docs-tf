# ec2_sqs.tf
# ------------------------------------------------------------
# Exercise E026 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_instance
# ------------------------------------------------------------

# Get User data
# curl http://169.254.169.254/latest/user-data


resource "aws_instance" "amazon_linux_2" {
  ami           = data.aws_ami.amazon_linux_2_latest.id
  instance_type = local.ec2_instance_type
  
  key_name      = local.key_name
  subnet_id     = aws_subnet.public.id


  vpc_security_group_ids = [ aws_security_group.allow_ssh_and_http_sg.id ]

  # si no se pone se autoasocia una IP aunque no se llegue a ella
  # associate_public_ip_address = false

  # AZ
  availability_zone = "${local.aws_region}a"

# Instance Profile to access to DynamoDb
  iam_instance_profile = aws_iam_instance_profile.ec2_access_to_dynamodb.name

 
  user_data = templatefile("${local.tf_shell_path}shell/e003/basic_http_server_dynamodb.x", 
  {
    ssh_secret_port = "${local.ssh_secret_port}" ,
    REGION = "${local.aws_region}" 
  } )

  user_data_replace_on_change = true

  tags = merge(tomap({ "Name" = "${local.prefix}-amazon-linux-2" }), local.common_tags)
}

