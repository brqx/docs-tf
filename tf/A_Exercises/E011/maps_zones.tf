# maps.tf
# -----------------------------------------------------------
# Exercise E001 .. E00n

variable "azs" {
  description = "Mapa de azs disponibles para la red"

  // Mapa de objetos
  #  type = tomap({
  type = map(object({
    name = string
    az   = string
    cidr = string
  }))

  ## VPC    : 10.20.0.0/16
  ## Subnet : 10.20.1.0/24 
  default = {
    // Valores por defecto para las zonas
    // No tienen que tener el mismo orden
    "zone_a" = {
      name = "public-a"
      az   = "a"
      cidr = "1"
    } , # end zone_a  }
    "zone_b" = {
      name = "public-b"
      az   = "b"
      cidr = "2"
    } # end zone_a  }

  }
}