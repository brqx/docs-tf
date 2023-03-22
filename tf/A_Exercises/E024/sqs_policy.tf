# sqs.tf
# -----------------------------------------------------------
# Exercise E023 .. E00N
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_iam_policy_document - aws_sqs_queue_policy
# ------------------------------------------------------------
# Nota : 
# - Politica para usar la cola
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------

# Definicion de una cola. Vamos a entendder los atributos


# Parece ser que es otra forma de definir las politicas
# Son permisos sobre  una cola
data "aws_iam_policy_document" "cola" {
  statement {
    sid    = "PolicyDocumentIamCola"
    effect = "Allow"

    actions   = [
      "sqs:ListQueues",
      "sqs:SendMessage",
      "sqs:ChangeMessageVisibility",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:DeleteMessage",
      "sqs:DeleteMessageBatch",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage"]
    resources = [aws_sqs_queue.main.arn]

# Este resources si lista todas las colas - VAmos a probar uno mas restringido
#    resources = ["*"]

    #condition {
    #  test     = "ArnEquals"
    #  variable = "aws:SourceArn"
    #  values   = [aws_sns_topic.main.arn]
    # }
  }
}

# Politica que permite enviar a cualquier pesona mensajes a esta cola
# Relaciona cola con politica

resource "aws_sqs_queue_policy" "main" {
  queue_url = aws_sqs_queue.main.id
  policy    = data.aws_iam_policy_document.cola.json
}


# Refs : 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue

