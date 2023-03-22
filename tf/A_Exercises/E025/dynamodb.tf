# sqs.tf
# -----------------------------------------------------------
# Exercise E023 .. E00N
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_dynamodb_table
# ------------------------------------------------------------
# Nota : 
# - Tabla DynamoDb
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------

# Definicion de una tabla. Vamos a entendder los atributos

# ------------------------------------------------------------

resource "aws_dynamodb_table" "main" {
  name           = "${var.table_name}"

  # Number of read/write units for this table. 
  # If the billing_mode is PROVISIONED, this field is required.
  read_capacity  = 10
  write_capacity = 10

  # Your primary key is a combination of the partition key and range key. 
  hash_key       = "id"
  # range_key      = "nombre"

  # billing_mode - 
  # Controls how you are charged for read and write throughput and how you manage capacity. 
  # The valid values are PROVISIONED and PAY_PER_REQUEST. Defaults to PROVISIONED.

  # range_key - (Optional, Forces new resource) Attribute to use as the range (sort) key.

  # Attribute type. Valid values are S (string), N (number), B (binary).

  # Si se cambia la tabla da este error : 
  # reading DynamoDB Table Item (mitabla|id||a3520|): ValidationException: 
  # The provided key element does not match the schema
  # La unica opcion es borrarla con aws
  

  attribute {  
    name = "id"   
    type = "S"   
  }

  #attribute {
  #  name = "nombre"
  #  type = "S"  
  #}

  tags = merge(tomap({ "Name" = "${local.prefix}-dynamodb-table" }), local.common_tags)

}



# Refs: 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item
# https://runebook.dev/es/docs/terraform/providers/aws/r/dynamodb_table --> DynamoDB en Castellano
# https://docs.aws.amazon.com/es_es/cli/latest/userguide/cli-services-dynamodb.html 
# https://linuxhint.com/dynamodb-cli-commands/

