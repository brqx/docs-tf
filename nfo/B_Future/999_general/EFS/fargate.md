# Fargate Information

Para conectar un volumen de EFS a una tarea de AWS Fargate, debe crear una definición de tarea (Task Definition) que incluya la configuración del contenedor efs VolumeConfiguration. 

Esta configuración define el sistema de archivos y el punto de montaje para el volumen EFS dentro del contenedor de la tarea.

Para crear una configuración de este tipo, crearemos tres módulos de Terraform creados específicamente para la implementación:

+Clúster de AWS Fargate
+Registro ECR e imagen de Docker con la aplicación de demostración
+Servicio de AWS Fargate

Los proveedores de capacidad de clúster de ECS son un tipo de orquestación de contenedores que ayuda a administrar y escalar aplicaciones en contenedores. 

Proporcionan una forma de ajustar dinámicamente la cantidad de contenedores en un clúster en función de la demanda, y ofrecen funciones como el escalado automático, la verificación del estado de las instancias y la supervisión de recursos. Los proveedores de capacidad se pueden utilizar tanto con Amazon ECS como con AWS Fargate. 

Cuando se usa con ECS, los proveedores de capacidad le permiten crear un clúster elástico que se puede ampliar o reducir automáticamente según sea necesario. 

Esto puede ayudar a mejorar la disponibilidad y el rendimiento de su aplicación al mismo tiempo que reduce los costos. 

Con AWS Fargate, puede usar proveedores de capacidad para lanzar contenedores sin tener que preocuparse por administrar las instancias del servidor.

#  

Estamos utilizando el recurso de datos archive_file Terraform para realizar un seguimiento de los cambios en la carpeta del código fuente de la aplicación y activar el proceso de reconstrucción de la imagen de Docker si algo cambia.

El recurso aws_ecr_repository es responsable de crear un registro ECR donde almacenaremos nuestra imagen de Docker.

Finalmente, estamos usando dos recursos nulos para crear una imagen de Docker y enviarla al registro creado.

## Servicio

Para finalizar nuestro ejemplo de AWS Fargate, creemos otra subcarpeta (6_fargate_service) en la carpeta raíz del proyecto para definir la configuración de Terraform para el servicio de Fargate. 

El servicio de Fargate es responsable de iniciar las tareas de Fargate (contenedores Docker), manteniéndolas en el estado EN EJECUCIÓN deseado.

Las partes más importantes de esta configuración son:

+ la variable container_definition que contiene la configuración del tiempo de ejecución del contenedor de Docker, incluida la sección mountPoints, que define qué volumen de EFS (sourceVolume) se monta en qué ubicación (containerPath) dentro del contenedor.

+ el recurso aws_ecs_task_definition Terraform contiene la configuración de archivos adjuntos de volumen EFS.

 Estamos usando la configuración del punto de acceso de EFS para conectarnos a una carpeta aislada dentro del volumen de EFS.

+ el recurso de grupo de seguridad aws_security_group permite el tráfico de entrada solo a un puerto específico del servicio y todo el tráfico saliente (egress)

Tan pronto como se haya definido e implementado esta configuración, las tareas de AWS Fargate pueden utilizar el volumen EFS montado como almacenamiento principal para cualquier archivo necesario para sus operaciones.


# Ref: https://anto.online/guides/how-to-install-aws-efs-on-rhel/
# Ref: https://arstech.net/centos-6-error-yumrepo-error-all-mirror-urls-are-not-using-ftp-http/