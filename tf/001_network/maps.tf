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


  default = {
    // Valores por defecto para las zonas
    // No tienen que tener el mismo orden
    "zone_a" = {
      name   = "public-a"
      pvname = "private-a"
      az     = "a"
      cidr   = "10.1.1.0/24"
      pvcidr = "10.1.10.0/24"
    }
    "zone_b" = {
      name   = "public-b"
      pvname = "private-b"
      az     = "b"
      cidr   = "10.1.2.0/24"
      pvcidr = "10.1.11.0/24"
    }
  }
}

output "valores" {
  description = "prueba de valores de la estructura"
  value       = var.azs["zone_a"].name # Devuelve public_a
}

output "hola" {
  description = "prueba de valores de la estructura"
  value       = "hola_001"
}