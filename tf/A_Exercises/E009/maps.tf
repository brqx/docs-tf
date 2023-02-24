# maps.tf
# -----------------------------------------------------------
# Exercise E008 .. E00n

variable "azs" {
  description = "Mapa de azs disponibles para la red"

  // Mapa de objetos
  #  type = tomap({
  type = map(object({
    name = string
    az   = string
    cidr = string
    pvname = string
    pvcidr = string
  }))

  ## VPC    : 10.20.0.0/16
  ## Subnet_Pub : 10.20.1.0/24 
  ## Subnet_Prv : 10.20.101.0/24
  default = {
    // Valores por defecto para las zonas
    // No tienen que tener el mismo orden
    "zone_a" = {
      name = "public-a"
      az   = "a"
      cidr = "1"
      pvname = "private-a"
      pvcidr = "101"
    } # end zone_a  }
  }
}