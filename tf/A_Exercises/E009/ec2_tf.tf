# Method to render json policy | shell script
# E006 Exercise

# 

data "template_file" "ec2_shell_template" {
  template = file("${local.tf_shell_path}shell/e003/basic_http_server.x")

  # Son variables que se interpolan cuando se interpreta el fichero
  # Aqui es la region. No la zona
  # Importa el File system ID ... funciona
  # FS_ID = "${var.efs_id}"

  vars = {
    ssh_secret_port = "${local.ssh_secret_port}"
  }
}

# Https server

## Refs: 

# https://pancy.medium.com/running-a-https-python-server-on-ec2-in-5-minutes-6c1f0444a0cf
# https://caddyserver.com/