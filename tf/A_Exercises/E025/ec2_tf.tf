# ec2_tf.tf
# ------------------------------------------------------------
# Exercise E021 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Data : 
# template_file - 
# 
# ------------------------------------------------------------

# Method to render json policy | shell script
# E014 Exercise

# 

data "template_file" "ec2_shell_template" {
  template = file("${local.tf_shell_path}shell/e003/basic_http_server.x")

  # Son variables que se interpolan cuando se interpreta el fichero

  vars = {
    ssh_secret_port = "${local.ssh_secret_port}"
  }
}

