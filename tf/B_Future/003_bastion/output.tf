output "instance_public_ip" {
  description = "IP publica del Bastion"
  value       = aws_instance.bastion.public_ip
}