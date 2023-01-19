
# AWS Systems Manager (ssm, ec2messages, ssmmessages)
#
# SSM VPC Endpoints

# Uso del VPC endpoint
data "aws_vpc_endpoint_service" "ssm" {
  service      = "ssm"
  service_type = "Interface"
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id = aws_vpc.main.id

  private_dns_enabled = true
  service_name        = data.aws_vpc_endpoint_service.ssm.service_name
  vpc_endpoint_type   = "Interface"
  security_group_ids = [   aws_security_group.vpc_endpoint.id ]
  #subnet_ids = module.vpc.private_subnets

    tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-a-ssm-endpoint" })    )

}

# Relaciona Vpc Endpoint - Subnet
resource "aws_vpc_endpoint_subnet_association" "ssm" {
  vpc_endpoint_id = aws_vpc_endpoint.ssm.id
  subnet_id       = aws_subnet.public["zone_a"].id
}

# Grupo de seguridad del endpoint

resource "aws_security_group" "vpc_endpoint" {
  ingress {
    description = "Grupo de seguridad del Endpoint VPC. Permite entrada tcp HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr]
  }

  name   = "${local.prefix}-vpce-sg"
  vpc_id = aws_vpc.main.id
  
    tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-a-vpce-sg" })    )

}

# EC2Messages

data "aws_vpc_endpoint_service" "ec2messages" {
  service      = "ec2messages"
  service_type = "Interface"
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.main.id
  service_name      = data.aws_vpc_endpoint_service.ec2messages.service_name
  vpc_endpoint_type = "Interface"

  security_group_ids = [     aws_security_group.vpc_endpoint.id   ]

  private_dns_enabled = true

    tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-a-ec2messages-endpoint" })    )

}

resource "aws_vpc_endpoint_subnet_association" "ec2messages" {
  vpc_endpoint_id = aws_vpc_endpoint.ec2messages.id
  subnet_id       = aws_subnet.private["zone_a"].id
}

# SSM Messages

data "aws_vpc_endpoint_service" "ssmmessages" {
  service      = "ssmmessages"
  service_type = "Interface"
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.main.id
  service_name      = data.aws_vpc_endpoint_service.ssmmessages.service_name
  vpc_endpoint_type = "Interface"

  security_group_ids = [     aws_security_group.vpc_endpoint.id    ]

  private_dns_enabled = true

    tags = merge(
    local.common_tags,
    tomap({ "Name" = "${local.prefix}-public-a-ssmmessages-endpoint" })    )

}

# Relaciona Vpc - Subnet Privada
resource "aws_vpc_endpoint_subnet_association" "ssmmessages" {
  vpc_endpoint_id = aws_vpc_endpoint.ssmmessages.id
  subnet_id       = aws_subnet.private["zone_a"].id
}
