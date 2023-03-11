# ec2_tf.tf
# ------------------------------------------------------------
# Exercise E016 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Data : 
# template_file - 
# 
# ------------------------------------------------------------

# Method to render json policy | shell script
# E014 Exercise

# 

data "template_file" "ec2_shell_template" {
  template = file("${local.tf_shell_path}shell/e003/basic_http_server_alb.x")

  # Son variables que se interpolan cuando se interpreta el fichero

  vars = {
    ssh_secret_port = "${local.ssh_secret_port}"
  }
}

# ------------------------------------------------------------

data "template_file" "ec2_shell_template_second" {
  template = file("${local.tf_shell_path}shell/e003/basic_http_server_alb_second.x")

  # Son variables que se interpolan cuando se interpreta el fichero

  vars = {
    ssh_secret_port = "${local.ssh_secret_port}"
  }
}

# ------------------------------------------------------------

data "template_file" "ec2_shell_template_third" {
  template = file("${local.tf_shell_path}shell/e003/basic_http_server_alb_third.x")

  # Son variables que se interpolan cuando se interpreta el fichero

  vars = {
    ssh_secret_port = "${local.ssh_secret_port}"
  }
}

# Https server

## Refs: 

# https://pancy.medium.com/running-a-https-python-server-on-ec2-in-5-minutes-6c1f0444a0cf
# https://caddyserver.com/
