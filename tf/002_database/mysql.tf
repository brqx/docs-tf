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
  subnet_ids  =  [for zone in aws_subnet.private : zone.id]  # Ok
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
  engine_version          = "10.0"
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

resource "null_resource" "setup_db" {
  depends_on = ["aws_db_instance.main"] #wait for the db to be ready
  triggers = {
    file_sha = "${sha1(file("file.sql"))}"
  }
  provisioner "local-exec" {
    command = "mysql -u ${aws_db_instance.main.username} -p${var.db_password} -h ${aws_db_instance.main.address} < ${var.sqlfile}"
  }
}

