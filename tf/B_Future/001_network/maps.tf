# Archivo especial de variables para mapas

variable "azs" {
  description = "Mapa de azs disponibles para la red"

  // Mapa de objetos
  #  type = tomap({
  type = map(object({
    name   = string
    az     = string
    cidr   = string
    pvname = string
    pvcidr = string
  }))

  ## VPC : 30.1.0.0/16
  default = {
    // Valores por defecto para las zonas
    // No tienen que tener el mismo orden
    "zone_a" = {
      name   = "public-a"
      pvname = "private-a"
      az     = "a"
      cidr   = "30.1.1.0/24"
      pvcidr = "30.1.10.0/24"
    } # end zone_a
  }
}

#    To test ... only one zone
#    "zone_b" = {
#      name   = "public-b"
#      pvname = "private-b"
#      az     = "b"
#      cidr   = "30.1.2.0/24"
#      pvcidr = "30.1.11.0/24"
#    } # end zone_b


output "valores" {
  description = "Nombre Zone A"
  value       = var.azs["zone_a"].name # Devuelve public_a
}

output "information" {
  description = "Despliegue del Bastion"
  value       = "Despliegue del Bastion"
}