# ec2.tf
# -----------------------------------------------------------
# Exercise E000 .. E00N

# Se despliega en una subnet privada que no indicamos
# To run in macos :
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--=
# eval $(ssh-agent)
# ssh-add -k /Users/macminii7/farmacia2022_rsa.pem 
# -----------------------------------------------------------

resource "aws_instance" "amazon_linux_2" {
  ami           = data.aws_ami.amazon_linux_2_latest.id
  instance_type = local.ec2_instance_type
  
  # Fail : 
  # Error: creating EC2 Instance: InvalidKeyPair.NotFound: The key pair '/Library/tf/keys/farmacia2022_rsa' does not exist
  # key_name      = "/Library/tf/keys/farmacia2022_rsa"

  # key_name es el nombre de la clave, no donde esta
  # --------------------------------------------------

  # Works
  #key_name       = data.aws_key_pair.farmacia2022_tf.key_name
  # Works
  key_name      = local.key_name

  # Necesitamos el subnet id puesto que sino la crea en una subnet aleatoria

  # Ejemplo de Error : 
  # ------------------------------------------------------------------------------------
  # Error: creating EC2 Instance: InvalidParameter: 
  # Security group sg-04fa3f3871958c6cb and subnet subnet-0ea122ae6736e522c belong to different networks.
  # ------------------------------------------------------------------------------------
  
  subnet_id                   = aws_subnet.public.id

  vpc_security_group_ids = [ aws_security_group.allow_ssh_and_http_sg.id ]

  # associate_public_ip_address = false

  # AZ
  availability_zone = "${local.aws_region}a"
  
  user_data                   = data.template_file.ec2_shell_template.rendered
  user_data_replace_on_change = true

  tags = merge(tomap({ "Name" = "${local.prefix}-amazon-linux-2" }), local.common_tags)
}
