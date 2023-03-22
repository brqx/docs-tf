# sqs_role.tf
# ------------------------------------------------------------
# Exercise E024 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_iam_policy - aws_iam_role
# aws_iam_role_policy_attachment
# aws_iam_instance_profile
# ------------------------------------------------------------
# Nota : 
# - Politica IAM para enlazar a un profile de instancia EC2
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------


# ------------------------------------------------------------


# An error occurred (AccessDenied) when calling the ListQueues operation: Access to the resource https://eu-west-1.queue.amazonaws.com/ is denied.


resource "aws_iam_policy" "sqs_policy_cola" {
  name        = "SQS-${var.queue_name}-${data.aws_region.current.name}-cola_policy"
  description = "Enlaza la politica a la cola ${var.queue_name}"
  # Working - Nueva forma
  policy      = data.aws_iam_policy_document.cola.json
  
  # Working - Anterior forma
  # policy = data.template_file.sqs_sent_receive_policy_template.rendered
}

# ------------------------------------------------------------

# IAM Role - Comun para todos los servicios desde EC2

resource "aws_iam_role" "ec2_to_sqs_access_role" {
  name = "ec2-to-sqs-access"
  assume_role_policy = data.template_file.ec2_assume_role_template.rendered

}

# ------------------------------------------------------------

# Iam Role - Policy Attachment
# Relaciona rol con politica

resource "aws_iam_role_policy_attachment" "ec2_s3_attachment" {
  role       = aws_iam_role.ec2_to_sqs_access_role.name
  policy_arn = aws_iam_policy.sqs_policy_cola.arn
}

# ------------------------------------------------------------

# Iam Instance Profile

resource "aws_iam_instance_profile" "ec2_access_to_sqs" {
  name = "ec2-access-to-sqs"
  role = aws_iam_role.ec2_to_sqs_access_role.name
}