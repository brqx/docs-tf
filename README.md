<!-- Proyecto : # docs-tf -->
# Informacion de Terraform - Enfoque practico
<!-- Nivel 0 -  V0.0.3 - 2022 Ago-->

## Secciones

### Aterrizando con Terraform

Terraform es la mejor forma de trabajar y aprender AWS, puesto que puedes crear y destruir la infraestructura en momentos y de forma planificada

### Objetivo 

Arquitectura Terraform con : 

- Fargate escalable
- EFS
- RDS

<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->
<!--                        Ejercicio 01-a                        -->
<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->

### EJ01a - VPC publica ( Status : Working )

```
[[VPC - 10.0.0.0 - 10.0.0.0/16 - 64k hosts]] ----------------------------------------------------------------
   I
   I  [Subnet - 10.0.0.0/24 - 256 hosts ] - - - - - -- - - - - - - - 
   I     I   
   I     I   [EC2 (EIP - 5.6.7.8) ]  -----> Route -----> IG  
   I     I
```

#### Entidades de Terraform : 

resources :

<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->
<!--                        Ejercicio 01-b                        -->
<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->


### EJ01b - VPC publica - VPC privada (Status : Working ) 

```
[[VPC - 10.0.0.0 - 10.0.0.0/16 - 64k hosts]] ----------------------------------------------------------------
   I
   I  [Subnet - 10.0.0.0/24 - 256 hosts ] - - - - - -- - - - - - - - 
   I     I   
   I     I   [EC2 (EIP - 5.6.7.8) ]  -----> Route ----->  IG  
   I     I                                                ^
   I     I                                                I 
   I     I   [NATG] --------------------------------------I
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
<!--                        Ejercicio 04                          -->
<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->

### EJ04 - BASTION - VPC publica - VPC privada ( Status : Working ) 

```
[[VPC - 10.0.0.0 - 10.0.0.0/16 - 64k hosts]] ----------------------------------------------------------------
   I
   I  [Subnet - 10.0.0.0/24 - 256 hosts ] - - - - - -- - - - - - - - 
   I     I   
   I     I   [BASTION (EIP - 5.6.7.8) ]  -----> Route ----->  IG  
   I     I   [SG_BASTION]                                      ^
   I     I                                                     I 
   I     I   [NATG] -------------------------------------------I
----------------------------------------------------------------
   I  [Subnet - 10.0.1.0/24 - 256 hosts ] - - - - - -- - - - - - - - 
   I     I   
   I     I   [EC2 (Private IP - 10.0.1.23) ]  -----> Route -----> NATG  
   I     I   [Allow SG_BASTION]

```

#### Entidades de Terraform : 

resources :

data : 

variables 

locals


<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->
<!--                        Ejercicio 05                          -->
<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->

### EJ05 - Public EFS

```

[[VPC - 10.0.0.5 - 10.0.0.0/16 - 64k hosts]] ----------------------------------------------------------------
   I  [Subnet - 10.0.0.0/24 - 256 hosts ] - - - - - -- - - - - - - - 
   I     I   
   I     I   [EC2 (Public/Private IP - 10.0.0.23) ]  -----> Route -----> IG  
   I     I        I
   I     I        I
   I     I      [EFS]
```

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

