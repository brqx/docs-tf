# ec2_tf.tf
# ------------------------------------------------------------
# Exercise E021 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Data : 
# template_file - 
# ------------------------------------------------------------
# Nota : 
# - TF simple pasando el puerto solamaente e instalando stress en las instancias
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------

# 

data "template_file" "ec2_shell_template" {
  template = file("${local.tf_shell_path}shell/e003/basic_http_server_alb_stress.x")

  # Son variables que se interpolan cuando se interpreta el fichero

  vars = {
    ssh_secret_port = "${local.ssh_secret_port}"
  }
}

