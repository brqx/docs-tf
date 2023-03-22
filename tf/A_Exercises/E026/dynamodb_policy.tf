# sqs.tf
# -----------------------------------------------------------
# Exercise E023 .. E00N
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_iam_policy_document
# ------------------------------------------------------------
# Nota : 
# - Politica para usar la cola
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------

# Parece ser que es otra forma de definir las politicas
# Son permisos sobre  una tabla
data "aws_iam_policy_document" "dynamodb_all_list" {
  statement {
    sid    = "PolicyDocumentIamDynamoDbRead"
    effect = "Allow"

    # Ejemplo de todas las acciones 
    # actions = ["dynamodb:*"]
    actions   = [ "dynamodb:ListTables" ]
    resources = ["*"]

#    resources = [aws_dynamodb_table.main.arn]

  }
}

# ------------------------------------------------------------

data "aws_iam_policy_document" "dynamodb_read" {
  statement {
    sid    = "PolicyDocumentIamDynamoDbRead"
    effect = "Allow"

    # Ejemplo de todas las acciones 
    # actions = ["dynamodb:*"]
    actions   = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:ListTables",
      "dynamodb:Query",
      "dynamodb:Scan" ]
    resources = [aws_dynamodb_table.main.arn]

  }
}

# ------------------------------------------------------------

data "aws_iam_policy_document" "dynamodb_write" {
  statement {
    sid    = "PolicyDocumentIamDynamoDbWrite"
    effect = "Allow"

    actions   = [
      "dynamodb:DeleteItem",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:ListTables",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
      "dynamodb:UpdateTable" ]
    resources = [aws_dynamodb_table.main.arn]

  }
}


# Refs : 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue

