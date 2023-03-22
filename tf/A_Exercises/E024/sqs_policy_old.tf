# sqs_policy_old.tf
# ------------------------------------------------------------
# Exercise E024 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_iam_policy_document
# ------------------------------------------------------------
# Nota : 
# - Politica para usar la cola
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------


# ------------------------------------------------------------

# Template file for IAM Policy

# Esto no ha funcionado. Creo que el SID es para S3
data "template_file" "sqs_sent_receive_policy_template" {
  template = file("${local.tf_shell_path}policy/for_roles/sqs/ec2_sqs_rw.policy")

  # Son variables que se interpolan cuando se interpreta el fichero
  # Tengo dudas del SID aqui
  vars = {
    SID        = "${var.sqs_sid_name}"
    ACCOUNT_ID = "${local.account_id}"
    QUEUE_NAME = "${var.queue_name}"
    REGION     = "${local.aws_region}"
  }

}

# ------------------------------------------------------------

# Template file for IAM Role
# Este rol es valido para cualquier servicio

data "template_file" "ec2_assume_role_template" {
  template = file("${local.tf_shell_path}roles/assume_role_ec2.role")
}

