# ec2_tf.tf
# ------------------------------------------------------------
# Exercise E024 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Data : 
# template_file - 
# 
# ------------------------------------------------------------

# 

data "template_file" "ec2_shell_template" {
  template = file("${local.tf_shell_path}shell/e003/basic_http_server_sqs.x")

  # Son variables que se interpolan cuando se interpreta el fichero

  vars = {
    ssh_secret_port = "${local.ssh_secret_port}"
    REGION = "${local.aws_region}"
    QUEUE_URL = "${aws_sqs_queue.main.id}"
  }
}

