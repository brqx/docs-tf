# EFS Information

## ¿Qué es Amazon EFS?
Amazon Elastic File System (EFS) es un servicio de almacenamiento de archivos basado en la nube diseñado para ser escalable y de alta disponibilidad. EFS proporciona una interfaz simple consistente con los sistemas de archivos tradicionales, lo que facilita la migración de aplicaciones existentes a la nube. EFS se basa en la infraestructura de alto rendimiento de Amazon y utiliza almacenamiento redundante en múltiples zonas de disponibilidad (AZ) para brindar durabilidad y disponibilidad. 

EFS admite permisos de archivos compatibles con POSIX y listas de control de acceso (ACL), lo que lo hace ideal para usar en muchas cargas de trabajo, incluido el alojamiento web, la gestión de contenido y el análisis de Big Data. 


## Sistema de archivos EFS
Amazon EFS proporciona un sistema de archivos compatible con Network File System (NFS). 

NFS es un protocolo estándar que permite a las computadoras acceder a archivos a través de una red. Amazon EFS está diseñado para proporcionar almacenamiento de archivos escalable, confiable y de baja latencia para aplicaciones que se ejecutan en instancias de Amazon EC2, ECS y Fargate, y AWS Lambda.

El sistema de archivos EFS se puede montar y utilizar como cualquier otro sistema de archivos en Linux. EFS es altamente disponible y duradero, con múltiples copias de seguridad y capacidades de recuperación ante desastres. 

Amazon EFS está disponible en todas las regiones de AWS. Para obtener más información sobre EFS, consulte la Guía del usuario oficial de Amazon Elastic File System.

El sistema de archivos de Amazon EFS está administrado por el recurso de Terraform aws_efs_file_system.

## Destinos de montaje EFS --> aws_efs_mount_target

Un destino de montaje de AWS EFS es el punto de enlace de un sistema de archivos EFS, lo que permite acceder al sistema de archivos desde una instancia EC2. 

Cada destino de montaje tiene una dirección IP única asignada por Amazon EFS. 

Cuando crea un destino de montaje, especifica una subred de Amazon VPC y un grupo de seguridad de EC2 en el que crear el destino de montaje. 

El grupo de seguridad controla el acceso al destino de montaje. 

Puede crear hasta cinco destinos de montaje por sistema de archivos de zona de disponibilidad. 

Puede asociar cada destino de montaje con varias instancias EC2 a través de sus grupos de seguridad. 

Si lo hace, permite el acceso simultáneo al sistema de archivos desde varias instancias. 

Los objetivos de montaje son específicos de una región de AWS y no se pueden replicar entre regiones.

Los destinos de montaje de AWS EFS son administrados por el recurso de Terraform aws_efs_mount_target.

## Puntos de acceso EFS --> aws_efs_access_point

Los puntos de acceso de EFS proporcionan un único punto de entrada a un sistema de archivos de Amazon EFS. 

Con un punto de acceso de EFS, puede controlar cómo sus aplicaciones acceden a los datos en un sistema de archivos de Amazon EFS. 

Con un punto de acceso de EFS, puede aplicar políticas de seguridad, optimizar el rendimiento para diferentes cargas de trabajo y monitorear el acceso a los datos mediante el registro de CloudTrail. 

Puede crear un punto de acceso EFS en su cuenta de AWS. Luego, puede montar el sistema de archivos utilizando el punto de acceso a través del destino de montaje asociado con el punto de acceso. 

El destino de montaje proporciona la dirección (nombre DNS) y el número de puerto que genera Amazon EFS para el punto de acceso. Sus aplicaciones utilizan esta dirección para acceder a los datos almacenados en el sistema de archivos de Amazon EFS. 

Puede configurar un punto de acceso EFS para usar un nombre DNS personalizado o puede usar el nombre DNS predeterminado. 

Tenga en cuenta que debe crear un registro de alias de Route 53 para asignar su nombre de DNS personalizado al nombre de DNS predeterminado para su punto de acceso EFS. 

Los destinos de montaje de Amazon EFS son administrados por el recurso aws_efs_access_point Terraform.

## Destino de montaje EFS frente a punto de acceso EFS

Un destino de montaje de AWS EFS es un recurso de Amazon Elastic File System que crea en su VPC. 

Proporciona un punto final (ENI y nombre DNS) que puede usar para montar todo el sistema de archivos EFS. 

Un punto de acceso de EFS es una característica de Amazon Elastic File System que proporciona a los clientes acceso a nivel de subdirectorio a un EFS a través del destino de montaje de AWS EFS. 

Los clientes pueden conectarse a un punto de acceso de EFS y realizar operaciones de archivo en el subdirectorio específico. 

Si necesita compartir sus datos con varios clientes, le sugerimos que utilice un punto de acceso EFS. 

Tenga en cuenta que los puntos de acceso de EFS no funcionan sin el destino de montaje de AWS EFS, y los puntos de acceso de EFS no se pueden usar para proporcionar acceso a la raíz / del volumen de EFS. 

Para proporcionar acceso al directorio raíz de su volumen EFS, debe utilizar el destino de montaje de AWS EFS.

Puede utilizar ambos recursos para acceder a los recursos compartidos de AWS EFS en la nube y en las instalaciones.

## Política del sistema de archivos EFS

La política del sistema de archivos Elastic File System (EFS) es un conjunto de reglas que rigen cómo se almacenan los archivos en un sistema de archivos EFS. 

La política define cómo se organizan los datos dentro del sistema de archivos y qué tipos de archivos se pueden almacenar en el sistema de archivos. 

La política también determina cómo se replican los archivos en varios servidores y cuánto tiempo se retienen los archivos en el sistema de archivos. 

