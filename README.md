<!-- Proyecto : # docs-tf -->
# Informacion de Terraform - Enfoque practico
<!-- Nivel 0 -  V0.0.2 - 2022 Ago-->

## Secciones

### Aterrizando con Terraform

Terraform es la mejor forma de trabajar y aprender AWS, puesto que puedes crear y destruir la infraestructura en momentos y de forma planificada

### Objetivo 

Arquitectura Terraform con : 

- Fargate escalable
- EFS
- RDS

<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->

### EJ01 - VPC publica

```
[[VPC - 10.0.0.5 - 10.0.0.0/16 - 64k hosts]] ----------------------------------------------------------------
   I
   I  [Subnet - 10.0.0.0/24 - 256 hosts ] - - - - - -- - - - - - - - 
   I     I   
   I     I   [EC2 (EIP - 5.6.7.8) ]  -----> Route -----> IG  
   I     I
```

#### Entidades de Terraform : 

resources :

<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->

### EJ02 - VPC publica - VPC privada

```
[[VPC - 10.0.0.5 - 10.0.0.0/16 - 64k hosts]] ----------------------------------------------------------------
   I
   I  [Subnet - 10.0.0.0/24 - 256 hosts ] - - - - - -- - - - - - - - 
   I     I   
   I     I   [EC2 (EIP - 5.6.7.8) ]  -----> Route -----> IG  
   I     I
----------------------------------------------------------------
   I  [Subnet - 10.0.1.0/24 - 256 hosts ] - - - - - -- - - - - - - - 
   I     I   
   I     I   [EC2 (Private IP - 10.0.1.23) ]  -----> Route -----> NATG  
   I     I

```


#### Entidades de Terraform : 

resources :

data : 

variables 

locals




Ref: https://www.terraform.io/docs/providers/aws/r/vpc.html

Ref: https://hands-on.cloud/terraform-managing-aws-vpc-creating-public-subnet/

<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->

### EJ03 - VPC Privada

[[VPC - 10.0.0.5 - 10.0.0.0/16 - 64k hosts]] ----------------------------------------------------------------
   I  [Subnet - 10.0.1.0/24 - 256 hosts ] - - - - - -- - - - - - - - 
   I     I   
   I     I   [EC2 (Private IP - 10.0.1.23) ]  -----> Route -----> NATG  
   I     I


### Terraform - TF

#### Entidades de Terraform : 

resources --> Recursos que creas

data      --> Recursos existentes que usas

variables 

locals


<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->

## Brqx

La arquitectura que propongo es minimizar el uso de teclado en la ejecucióni de los comandos, a su vez que se autodocumenta y se prueba

El resultado es un sistema de scripting en base a Alias y Funciones , principalmente, adaptable a cualquier herramienta, metodología o época.

<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->

## Markdown

Es un repaso a algunas estructuras sintácticas útiles en el sistema de documentación de Github (md - MarkDown)

<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->

## Referencias

https://ao.ms/solved-error-acquiring-the-state-lock-in-terraform/

