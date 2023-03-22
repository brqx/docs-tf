# sns_topic.tf
# ------------------------------------------------------------
# Exercise E022 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_sns_topic
# aws_sns_topic_subscription
# aws_sns_topic_policy
# aws_iam_policy_document
# ------------------------------------------------------------

resource "aws_sns_topic" "prueba" {
  name = "prueba-topic-abc"
}

# Crea una subscripcion que es necesario confirmar
resource "aws_sns_topic_subscription" "prueba_sub" {
  topic_arn = aws_sns_topic.prueba.arn
  protocol  = "email"
  endpoint  = local.email
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.prueba.arn

  policy = data.aws_iam_policy_document.sns-topic-policy.json
}

data "aws_iam_policy_document" "sns-topic-policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        "${local.account_id}",
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "${aws_sns_topic.prueba.arn}",
    ]

    sid = "__default_statement_ID"
  }

}

# Pending

##  alarm_actions = ["${aws_sns_topic.prueba.arn}"]



