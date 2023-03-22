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


data "template_file" "dynamodb" {
  template = file("${local.tf_shell_path}items/dynamodb/item_01.dynamodb")
}

resource "aws_dynamodb_table_item" "elemento_tablita_04" {
  table_name = aws_dynamodb_table.main.name
  hash_key   = aws_dynamodb_table.main.hash_key

  # Funcion file No me esta funcionando
  item = data.template_file.dynamodb.rendered
}


resource "aws_dynamodb_table_item" "elemento_tablita_05" {
  table_name = aws_dynamodb_table.main.name
  hash_key   = aws_dynamodb_table.main.hash_key

  # Funcion file No me esta funcionando
  item = file("${local.tf_shell_path}items/dynamodb/item_02.dynamodb")
}



# Refs: 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item
# https://runebook.dev/es/docs/terraform/providers/aws/r/dynamodb_table --> DynamoDB en Castellano
# https://docs.aws.amazon.com/es_es/cli/latest/userguide/cli-services-dynamodb.html 
# https://linuxhint.com/dynamodb-cli-commands/

