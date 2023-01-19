# EFS Information

## ¿Qué es Amazon EFS?
Amazon Elastic File System (EFS) es un servicio de almacenamiento de archivos basado en la nube diseñado para ser escalable y de alta disponibilidad. 

EFS proporciona una interfaz simple consistente con los sistemas de archivos tradicionales, lo que facilita la migración de aplicaciones existentes a la nube. 

EFS se basa en la infraestructura de alto rendimiento de Amazon y utiliza almacenamiento redundante en múltiples zonas de disponibilidad (AZ) para brindar durabilidad y disponibilidad. 

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

## Sistema EFS (aws_efs_file_system)


El recurso aws_efs_file_system Terraform define un volumen EFS. 

Utilice este recurso de Terraform para crear AWS Elastic FileSystems con la frecuencia que necesite.

Una de las excelentes características de Amazon EFS es que puede hacer la transición automática de archivos a niveles de almacenamiento de menor costo a medida que envejecen. 

Esta política de ciclo de vida del almacenamiento lo ayuda a reducir los costos generales de almacenamiento al mover automáticamente los archivos a los que no se ha accedido por un tiempo a niveles de almacenamiento más económicos. 

Puede configurar la política de transición para que suceda automáticamente o iniciar manualmente el proceso de transición cuando lo desee. 

Los archivos de transición que ya no se necesitan a niveles de almacenamiento de menor costo lo ayudarán a ahorrar dinero en su factura general de almacenamiento de AWS.

Puede configurar la política de ciclo de vida de almacenamiento de AWS EFS mediante el recurso lifecycle_policy que especifica cuánto tiempo lleva hacer la transición de los archivos a la clase de almacenamiento IA cuando nadie accede a ellos. 

Los valores válidos para el parámetro Transition_to_ia son:

DESPUÉS_7_DÍAS
DESPUÉS_14_DÍAS
DESPUÉS_30_DÍAS
DESPUÉS_60_DÍAS
DESPUÉS_90_DÍAS

El recurso aws_efs_file_system_policy contiene la política de EFS para imponer el acceso de la instancia EC2, la tarea Fargate y AWS Lambda a través del destino de montaje y los puntos de acceso (el acceso está restringido por los roles de recursos de IAM). 

Además de eso, estamos obligando a los usuarios a utilizar una conexión cifrada (la condición aws:SecureTransport).

** Se desactiva para EC2

aws_efs_mount_target es el recurso de Terraform que le permite exponer el EFS de AWS a las subredes de VPC al crear ENI en las subredes de VPC y agregar los registros requeridos a su resolución de DNS

El punto de montaje de EFS utiliza ENI para conectarse a la subred de EFS, y ENI debe tener un grupo de seguridad de EFS (aws_security_group) asociado para permitir el tráfico NFS (2049/TCP) de fuentes confiables. 

Se creará un grupo de seguridad predeterminado si no se proporciona ningún grupo de seguridad. 

Para evitar errores de configuración de acceso, recomendamos crear siempre un grupo de seguridad directamente y asociarlo con el recurso de AWS requerido. 

Por último, el destino de montaje de AWS EFS debe adjuntarse a cada subred de VPC (EFS) en la que planee utilizar el volumen de AWS EFS.

Dos recursos aws_efs_access_point adicionales nos permiten proporcionar un acceso granular fino a AWS EFS y aislar a los clientes conectados a través del punto de acceso lambda EFS a la subcarpeta /lambda y a los clientes conectados a través del punto de acceso fargate a la carpeta /fargate.

Los sistemas de archivos de EFS se pueden importar utilizando el destino de montaje de AWS EFS o el ID del punto de acceso de EFS.

Los roles de IAM en blanco, que cumplimos con los permisos requeridos de módulos Terraform separados, se definen en un archivo separado:

La variable local ec2_file_system_local_mount_path almacena la ubicación del punto de montaje en la instancia EC2 (donde estamos montando el volumen EFS).

El recurso de datos aws_ami Terraform nos permite consultar información sobre la última AMI de Amazon Linux 2.

Usamos el recurso aws_iam_policy_attachment para adjuntar la política AmazonSSMManagedInstanceCore al rol de IAM de la instancia EC2 que hemos definido en el módulo 2_efs Terraform.

La política de AmazonSSMManagedInstanceCore es una política integrada que proporciona permisos para que Systems Manager realice acciones básicas en sus instancias. 

Esto incluye acciones como instancias de administración remota mediante la consola web de AWS o la CLI de AWS, ejecutar comandos y obtener información de la instancia. 

Para usar Systems Manager, debe usar los permisos de política de AmazonSSMManagedInstanceCore. 

Si intenta administrar la instancia EC2 mediante Systems Manager sin esta política, recibirá un error.

## Introducción a Administrador de sistemas de AWS

El recurso aws_iam_instance_profile es necesario para crear un perfil de instancia de IAM, un perfil de instancia de IAM es una configuración de lanzamiento que puede usar para lanzar instancias con un rol de IAM.

Luego, usamos el recurso aws_network_interface para especificar una subred a la que queremos conectar nuestra instancia EC2 y el recurso del grupo de seguridad aws_security_group para permitir el tráfico requerido. 

En nuestro caso, permitimos todo tipo de tráfico saliente (salida) de la instancia EC2 y evitamos todo el tráfico entrante.

Finalmente, estamos definiendo el recurso aws_instance Terraform y usando un script Bash simple en user_data para crear un punto de montaje, instalar/actualizar, las utilidades de Amazon EFS montan el punto de montaje EFS en el directorio requerido en el sistema de archivos y actualizan el archivo /etc/fstab para que que la instancia puede montar automáticamente el volumen EFS después de reiniciar. 

Además, estamos creando algunos archivos de prueba en el volumen EFS para probar el servicio Fargate implementado y AWS Lambda más adelante.


## Referencias


Ref: https://github.com/hands-on-cloud/managing-amazon-efs-terraform
