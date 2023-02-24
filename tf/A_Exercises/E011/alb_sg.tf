# alb_sg.tf
# ------------------------------------------------------------
# Exercise E011 .. E00n
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_security_group - 
# aws_security_group_rule
# ------------------------------------------------------------

# Regla de entrada WEB --> LB
resource "aws_security_group_rule" "web80_to_lb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.test_alb_sg.id
  depends_on        = [aws_security_group.test_alb_sg]
}

# ----------------------------------------------------------

resource "aws_security_group_rule" "web443_to_lb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.test_alb_sg.id
  depends_on        = [aws_security_group.test_alb_sg]
}


# ----------------------------------------------------------

# Regla de salida
resource "aws_security_group_rule" "lb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  # La salida debe ser a Fargate
  # source_security_group_id = local.fargate_sg  
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.test_alb_sg.id
  depends_on        = [aws_security_group.test_alb_sg]

}

# ----------------------------------------------------------

resource "aws_security_group" "test_alb_sg" {
  name = "test_alb"
  description = "ALB Security Group"
  vpc_id = aws_vpc.main.id

  tags = merge(tomap({ "Name" = "${local.prefix}-amazon-alb-sg" }), local.common_tags)

}