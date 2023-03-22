# sqs.tf
# -----------------------------------------------------------
# Exercise E023 .. E00N
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_dynamodb_table - aws_dynamodb_table_item
# ------------------------------------------------------------
# Nota : 
# - Tabla DynamoDb
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# ------------------------------------------------------------

# Definicion de una cola. Vamos a entendder los atributos

# Error de formato
# Error: Invalid format of "item": Decoding failed: invalid character '}' looking for beginning of object key string

# Error: 1 error occurred:
# * all attributes must be indexed. Unused attributes: ["nombre"]

resource "aws_dynamodb_table_item" "elemento_tablita_01" {
  table_name = aws_dynamodb_table.main.name
  hash_key   = aws_dynamodb_table.main.hash_key

  # Es un solo item com varios campos
  # Los campos no tienen por que existir en la creaccion
  # Solo crea el primero
  item = <<ITEM
{
  "id": {"S": "a3520"},
  "nombre": {"S": "Pedro"},
  "edad": {"N": "25"},
  "apuestas": {"N": "34"}
}
ITEM
}

resource "aws_dynamodb_table_item" "elemento_tablita_02" {
  table_name = aws_dynamodb_table.main.name
  hash_key   = aws_dynamodb_table.main.hash_key

  # Es un solo item com varios campos
  # Los campos no tienen por que existir en la creaccion
  # Solo crea el primero
  item = <<ITEM
{
  "id": {"S": "a3190"},
  "nombre": {"S": "Juana"},
  "edad": {"N": "21"},
  "apuestas": {"N": "3"}
}
ITEM
}

resource "aws_dynamodb_table_item" "elemento_tablita_03" {
  table_name = aws_dynamodb_table.main.name
  hash_key   = aws_dynamodb_table.main.hash_key

  # Es un solo item com varios campos
  # Los campos no tienen por que existir en la creaccion
  # Solo crea el primero
  item = <<ITEM
{
  "id": {"S": "a8170"},
  "nombre": {"S": "Daniela"},
  "edad": {"N": "17"}
}
ITEM
}


# Refs: 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item
# https://runebook.dev/es/docs/terraform/providers/aws/r/dynamodb_table --> DynamoDB en Castellano
# https://docs.aws.amazon.com/es_es/cli/latest/userguide/cli-services-dynamodb.html 
# https://linuxhint.com/dynamodb-cli-commands/

