### AWS Systems Manager - SSM

AWS Systems Manager (antes conocido como SSM) es un servicio de AWS que puede utilizar para ver y controlar su infraestructura en AWS. 

Systems Manager lo ayuda a mantener la seguridad y la conformidad mediante el análisis de sus nodos administrados y el informe sobre las infracciones de las políticas que detecte o la toma de medidas correctivas con respecto a estas.

Un nodo administrado es cualquier máquina configurada para Systems Manager. Systems Manager admite instancias de Amazon Elastic Compute Cloud (Amazon EC2), dispositivos de borde, servidores locales y máquinas virtuales, además de VM en otros entornos de nube. Para sistemas operativos, Systems Manager admite Windows Server, macOS, Raspberry Pi OS (anteriormente Raspbian) y múltiples distribuciones de Linux.

### AWS Systems Manager - SSM Agent

El agente de AWS Systems Manager (SSM Agent) es el software de Amazon que se ejecuta en instancias de Amazon Elastic Compute Cloud (Amazon EC2), dispositivos de borde, servidores locales o máquinas virtuales. 

SSM Agent permite que Systems Manager actualice, administre y configure estos recursos. 

El agente procesa las solicitudes desde el servicio de Systems Manager en la Nube de AWS y, a continuación, las ejecuta tal y como se especifica en la solicitud. 

A continuación, SSM Agent devuelve información de estado y de ejecución al servicio de Systems Manager mediante el Amazon Message Delivery Service (prefijo de servicio: ec2messages).