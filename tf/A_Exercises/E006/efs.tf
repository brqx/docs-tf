# efs.tf
# -----------------------------------------------------------
# Exercise E006 .. E00N
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# TF Entities : 
# aws_efs_file_system - aws_efs_mount_target
# -----------------------------------------------------------

# Obtenemos el FS EFS por el ID
data "aws_efs_file_system" "my_efs" {
  file_system_id = var.efs_id
}

# Es el montaje que se hace del efs en la subnet
resource "aws_efs_mount_target" "alpha" {
  file_system_id = data.aws_efs_file_system.my_efs.id
  subnet_id      = aws_subnet.public.id
  # Necesita un grupo de seguridad
  security_groups = [aws_security_group.efs_sg.id]  
}

