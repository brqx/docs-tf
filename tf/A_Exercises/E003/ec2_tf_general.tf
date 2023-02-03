# ec2_tf_general.tf
# -----------------------------------------------------------
# Exercise E003 .. E00N

# Method to render json policy | shell script
# E003 Exercise

# En el momento en que tiene variables, estas deben ser definidas, sino da este error : 
# failed to render : <template_file>:7,29-44: Unknown variable; There is no variable named "ssh_secret_port"

data "template_file" "ec2_shell_template" {
  template = file("${local.tf_shell_path}shell/e003/basic_http_server.x")

  # Son variables que se interpolan cuando se interpreta el fichero
  vars = {
    ssh_secret_port = "${local.ssh_secret_port}"
  }

}

# Https server

## Refs: 

# https://pancy.medium.com/running-a-https-python-server-on-ec2-in-5-minutes-6c1f0444a0cf
# https://caddyserver.com/