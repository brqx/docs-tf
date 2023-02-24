<!-- Proyecto : # docs-tf -->
# Informacion de Terraform - Realidad practica
<!-- Nivel 1 -  V0.0.3 - 2023 Feb -->

## Secciones

### Aprendiendo/Recordando Aws

El principal problema de aprender Aws es que te enfrentas a un universo de nuevos conceptos, nuevas formas de enfocar un sistema ;  unido a que todo cuesta bastante dinero e incluso hay aspectos que ves muy pesados para hacer de entrada.

Todo esto se ha ido intentando aliviar con herramientas, pero a primera vista lo que hace es que tengas que saber muchas más cosas para poder llegar a aprender Aws.

Entonces, para poder empezar debes tener capacidad de entendimiento, para lo cual lo más conveniente es una certificación de Arquitectura, Desarrollo o Sistemas.

Esa es la primera premisa, luego una vez los conceptos no te asustan, entonces debes intentar aplicarlos y viene el segundo problema ... es complejo , amplio , arduo , duro y ... en general ... se tarda mucho en todo.

Ahora vamos con las soluciones : 

- Terraform              : Mejora Cloud Formation de Aws - que es un engorro - ; y te da una herramienta para aprender/generar infraestructuras donde puedes crearlas y destruirlas, con lo cual puedes poner en práctica tus conocimientos y tus ideas para adaptar proyectos a la nube, ajustando al máximo tus gastos; pues recordemos que todo lo que esté creado, aun sin usarse, cuesta dinero en Cloud.

- Jenkins / Gitlab       : 

El objetivo de estas herramientas es intentar automatizar la generación de software y de recursos hardware de los proyectos.

Estas herramientas estan orientadas a ello, a manejar lo que se llaman tuberias o Pipelines, donde en base a distintos estados como puede hacerse en un autómata se van ajustando los despliegues de nuevas versiones y/o aplicaciones.

- Kubernetes / Openshift : 

Cuando ya los proyectos son a mayor escala , pues te permite homogeneizar los despliegues de los mismos con una estructura más homogénea y muy potente. 

Por supuesto a nivel de configuración es más o menos como terraform ( plantillas de texto ), por lo que es facilmente versionable , reproducible y extensible

Hay más, pero estas son las principales que mueven los sistemas hoy en día ( 2023 ) en todas las grandes empresas del mundo.

Ahora bien ... ¿ Cómo aprenderlo ? 

Pues aparte de minimizar los costes, hay que minimizar la complejidad de las mismas y es justo este segundo punto mi objetivo con este proyecto.

### Recordando Terraform

El problema con estas tecnologías tan complejas y amplias es que una estructura con gran complejidad, que se alcanza de forma rápida en cuanto intentamos usar varias instancias, al estar tiempo sin usarlo, se olvida.

Entonces es necesario tener ejercicios de readaptación

A su vez hay tanta información y es tan complejo que los tutoriales realmente confunden, ya que mezclan y mezclan cosas para ser más llamativos y dar la sensación que son mejores.

Luego los cursos están bien, si están muy bien, pero aún con ellos se queda incompleto y aunque tu eres capaz como ingeniero de seguirlos y de completarlos, ayudado por más cursos y certificaciones, aún así falta una práctica real donde tu vayas decidiendo que hacer y cómo hacerlo, en resumen te autopreparas para tu propia arquitectura terraform aws.


### A_Exercises - Ejercicios

La ruta de github para esto es : 

https://github.com/brqx/docs-tf/tree/main/nfo/A_Exercises

Son configuraciones de complejidad escalable que te permiten reentender terraform

Ejercicio 01 : Preparar una estructura en Terraform con Backend y Variables ( Status : Working )   \
Ejercicio 02 : Generar una VPC y una subnet                        ( Status : Working )                \
Ejercicio 03 : Montar una instancia EC2 con una VPC en una Zona    ( Status : Working )            \
Ejercicio 04 : Habilitar S3 para que sea accesible via rol por la instancia EC2 ( Status : Working )   \
Ejercicio 05 : Habilitar S3FS para que sea accesible desde la EC2 ( Status : Working )                 \
Ejercicio 06 : Habilitar EFS para que sea accesible desde la EC2 ( Status : Working)                   \            
Ejercicio 07 : Habilitar EFS AP para que sea accesible desde la EC2 ( Status : Working )               

Ejercicio 08 : Preparar dominio en Route 53 que lanze la instancia de EC2 Publica ( Status : Working)              \
Ejercicio 09 : Preparar dominio Route 53 que lanze la instancia de EC2 Privada - Requiere LB  ( Status : Pending ) \ 
Ejercicio 10 : Habilitar SSL en Route 53. Comprobacion de registros ( Status : Pending )

Ejercicio 11 : Redirecion de Route53 a un balanceador y del mismo a las EC2 Publica ( Status : Pending )
Ejercicio 12 : Bloqueo de acceso a las instancias. Solo cargan desde el balanceador ( Status : Pending )
Ejercicio 13 : Habilitar SSL en los ALB para ser invocados por Route 53 ( Status : Pending )
Ejercicio 14 : Regla en balanceador. Si SSL o mobile Instancia1 sino Instancias2 ( Status : Pending )
Ejercicio 15 : Probar balanceador de Red : Network 


### B_Future  - Futuro - Arquitectura escalable 

Segun vamos cogiendo practica de nuevo con terraform, podemos redefinir nuestra arquitectura escalable
Arquitectura Terraform con : 

- Fargate escalable                                \
- EFS                                              \
- RDS

Realmente lo que quiero llegar a conseguir es : 

- Drupal , Wordpress y Magento funcionando en Cloud. Analisis de opciones para mejor rendimiento y costes
- NodeJs /Nginx funcionando
- Mysql/Aurora funcionando

<!-- ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==-- -->

## Referencias

https://ao.ms/solved-error-acquiring-the-state-lock-in-terraform/


