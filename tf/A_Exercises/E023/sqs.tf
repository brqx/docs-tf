# sqs.tf
# -----------------------------------------------------------
# Exercise E023 .. E00N
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_sqs_queue
# ------------------------------------------------------------
# Nota : 
# - Cola SQS
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------

# Definicion de una cola. Vamos a entendder los atributos

resource "aws_sqs_queue" "main" {
  name                      = var.queue_name

  # tiempo en segundos que se retrasará la entrega de todos los mensajes en la cola ( 0 - 900 ) 
  # El valor predeterminado para este atributo es 0 segundos.
  # delay_seconds             = 90
  
  max_message_size          = 2048

  # Cantidad de segundos que Amazon SQS retiene un mensaje ( 60 -1 minuto- a 1209600 -14 días- )
  # valor predeterminado para este atributo es 345600 (4 días)

  message_retention_seconds = 86400

  # tiempo durante que ReceiveMessage esperará a un mensaje (sondeo largo) ( 0 a 20 segundos)
  # El valor predeterminado para este atributo es 0 
  # loque significa que la llamada regresará inmediatamente.  

  # receive_wait_time_seconds = 10

  # Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys
  # sqs_managed_sse_enabled = true

  # fifo_queue                  = true
  # content_based_deduplication = true  

  # kms_master_key_id         = aws_kms_key.primary.arn

  # tiempo de espera de visibilidad para la cola. ( 0 a 43200 - 12 horas)
  # El valor predeterminado de este atributo es 30. 
  
  visibility_timeout_seconds    = 0 

  # depends_on = [  aws_s3_bucket.cloudtrailbucket,    aws_kms_key.primary   ]
}

# Refs : 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue

