# ----------------------------------------------------------
# Info - 2022_Jul
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------
# TF Entities : 
# aws_db_subnet_group
# aws_security_group
# aws_db_instance

resource "aws_db_subnet_group" "main" {
  name = "${local.prefix}-main"

  #subnet_ids = aws_subnet.private["*"].id # Fail
  subnet_ids = [for zone in aws_subnet.private : zone.id] # Ok
  #subnet_ids  = [ "${aws_subnet.private[*]}.id" ] # Fail

  #  subnet_ids = [
  #    aws_subnet.private["zone_a"].id,
  #    aws_subnet.private["zone_b"].id


  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-main-db-subnet-group" })
  )
}

# ----------------------------------------------------------

resource "aws_security_group" "rds_postgresql" {
  description = "Allow access to the RDS database instance."
  name        = "${local.prefix}-rds-inbound-access-postgresql"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Puertos de acceso Postgresql"
    protocol  = "tcp"
    from_port = 5432
    to_port   = 5432
  }

  tags = local.common_tags
}

# ----------------------------------------------------------

resource "aws_security_group" "rds_mysql" {
  description = "Allow access to the RDS database instance."
  name        = "${local.prefix}-rds-inbound-access-mysql"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Puertos de acceso Mysql"
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
  }

  tags = local.common_tags
}

# ----------------------------------------------------------

resource "aws_security_group" "rds_proxy" {
  description = "Allow access to the RDS database instance."
  name        = "${local.prefix}-rds-inbound-access-proxy"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
  }

  egress {
    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306
  }

  tags = local.common_tags
}

# ----------------------------------------------------------

resource "aws_db_instance" "main" {
  identifier              = "${local.prefix}-db"
  name                    = "recipe"
  allocated_storage       = 5
  storage_type            = "gp2"
  engine                  = "mariadb"
  engine_version          = "10.2.39"
  instance_class          = "db.t2.micro"
  db_subnet_group_name    = aws_db_subnet_group.main.name
  password                = var.db_password
  username                = var.db_username
  backup_retention_period = 0
  multi_az                = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds_mysql.id]

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-main-db-instance" })
  )
}

# Mejora de rendimiento con un proxy

resource "aws_db_proxy" "main" {
  name                   = "db-proxy-mysql"
  debug_logging          = false
  engine_family          = "MYSQL"
  idle_client_timeout    = 1800
  require_tls            = true
  role_arn               = "arn:aws:iam::847529687099:role/aws-service-role/rds.amazonaws.com/AWSServiceRoleForRDS"
  vpc_security_group_ids = [aws_security_group.rds_proxy.id]
  vpc_subnet_ids         = [for zone in aws_subnet.private : zone.id]

  depends_on = aws_db_instance.main

  auth {
    auth_scheme = "SECRETS"
    description = "example"
    iam_auth    = "DISABLED"
    secret_arn  = "arn:aws:secretsmanager:eu-west-1:847529687099:secret:dev/mysql/recipeapp-secret-dyW2tA"
  }

  tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-proxy" })
  )

  # Secreto ya creado que quiero usar
  # arn:aws:secretsmanager:eu-west-1:847529687099:secret:dev/mysql/recipeapp-secret-dyW2tA

}

# Uso secreto existente - se antepone data
data "aws_secretsmanager_secret" "rds_secret" {
  arn = "arn:aws:secretsmanager:eu-west-1:847529687099:secret:dev/mysql/recipeapp-secret-dyW2tA"
}

# Uso de rol existente - No funciona
# data "aws_iam_role" "connect_rds" {
#  name = "AWSServiceRoleForRDS"
#  arn = "arn:aws:iam::847529687099:role/aws-service-role/rds.amazonaws.com/AWSServiceRoleForRDS"

