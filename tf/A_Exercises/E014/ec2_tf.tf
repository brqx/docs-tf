# Method to render json policy | shell script
# E014 Exercise

# 

data "template_file" "ec2_shell_template" {
  template = file("${local.tf_shell_path}shell/e005/basic_http_server_s3fs_alb.x")

  # Son variables que se interpolan cuando se interpreta el fichero

  vars = {
    ssh_secret_port = "${local.ssh_secret_port}"
    BUCKET = "${var.s3_bucket_name}"
    FOLDER = "${var.s3_folder}"
    FILE = "${var.s3_file}"
    EC2_ROLE= "${aws_iam_role.ec2_to_s3_access_role.name}"
    UID_EC2_USER = "${var.uid_ec2_user}"
  }
}

# Https server

## Refs: 

# https://pancy.medium.com/running-a-https-python-server-on-ec2-in-5-minutes-6c1f0444a0cf
# https://caddyserver.com/
