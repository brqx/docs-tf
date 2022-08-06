# ----------------------------------------------------------
# Info - 2022_Ago
# Terraform v1.2.6
# + provider.aws v3.37.0
# ----------------------------------------------------------
# TF Com: output

# ----------------------------------------------------------


output "bastion_public_ip" {
  description = "IP publica del Bastion"
  value       = aws_instance.bastion.public_ip
}

output "tercera_public_ip" {
  description = "IP publica de la tercera EC2 (no debe conectar a la privada)"
  value       = aws_instance.third_ec2.public_ip
}

output "internal_private_ip" {
  description = "IP publica de la tercera EC2 (no debe conectar a la privada)"
  value       = aws_instance.private_ec2.private_ip
}
