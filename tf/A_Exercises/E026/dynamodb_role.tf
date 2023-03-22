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


resource "aws_iam_policy" "dynamodb_policy_read" {
  name        = "DynamoDb-${var.table_name}-${data.aws_region.current.name}-read"
  description = "Enlaza la politica a la tabla ${var.table_name}"
  policy      = data.aws_iam_policy_document.dynamodb_read.json
}

# ------------------------------------------------------------

resource "aws_iam_policy" "dynamodb_policy_write" {
  name        = "DynamoDb-${var.table_name}-${data.aws_region.current.name}-write"
  description = "Enlaza la politica a la tabla ${var.table_name}"
  policy      = data.aws_iam_policy_document.dynamodb_write.json
}

# ------------------------------------------------------------

resource "aws_iam_policy" "dynamodb_policy_all_list" {
  name        = "DynamoDb-${var.table_name}-${data.aws_region.current.name}-all_list"
  description = "Enlaza la politica a la tabla ${var.table_name}"
  policy      = data.aws_iam_policy_document.dynamodb_all_list.json
}

# ------------------------------------------------------------

# IAM Role - Comun para todos los servicios desde EC2

resource "aws_iam_role" "ec2_to_dynamodb_access_role" {
  name = "ec2-to-dynamodb-access"
  assume_role_policy = data.template_file.ec2_assume_role_template.rendered
}

# ------------------------------------------------------------

# Iam Role - Policy Attachment
# Relaciona rol con politica

resource "aws_iam_role_policy_attachment" "ec2_dynamodb_read_attachment" {
  role       = aws_iam_role.ec2_to_dynamodb_access_role.name
  policy_arn = aws_iam_policy.dynamodb_policy_read.arn
}

resource "aws_iam_role_policy_attachment" "ec2_dynamodb_write_attachment" {
  role       = aws_iam_role.ec2_to_dynamodb_access_role.name
  policy_arn = aws_iam_policy.dynamodb_policy_write.arn
}

resource "aws_iam_role_policy_attachment" "ec2_dynamodb_all_list_attachment" {
  role       = aws_iam_role.ec2_to_dynamodb_access_role.name
  policy_arn = aws_iam_policy.dynamodb_policy_all_list.arn
}

# ------------------------------------------------------------

# Iam Instance Profile

resource "aws_iam_instance_profile" "ec2_access_to_dynamodb" {
  name = "ec2-access-to-dynamodb"
  role = aws_iam_role.ec2_to_dynamodb_access_role.name
}

# Template file for IAM Role - Comun para todos los servicios

data "template_file" "ec2_assume_role_template" {
  template = file("${local.tf_shell_path}roles/assume_role_ec2.role")
}