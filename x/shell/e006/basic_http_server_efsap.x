#!/bin/bash
# Exercise E006
# Change SSH port
# Aws Starting Script for EC2 instance
# V.0.0.2 - Brqx Architectures - 2023_Feb
# ------------------------------------------------------------
# Vamos a ocultar el puerto con una variable
sed -i "s/\#Port\ 22/Port ${ssh_secret_port}/g" /etc/ssh/sshd_config
service sshd restart
# Server code
yum update -y
yum install -y httpd git
yum install -y amazon-efs-utils
# Yum dependences
systemctl start httpd.service
systemctl enable httpd.service
echo "Hi Friend of brqx , I am $(hostname -f) hosted by Terraform" >  /var/www/html/index.html
## Mount EFS

# Si ponemos esto tarda un poco mas en iniciarse
# al iniciarse lo genera en el raiz
mkdir ${FOLDER}
# The EFS file systems can be imported using the AWS EFS mount target or EFS access point ID
# Para montar el punto de acceso el formato es algo distinto
mount -t efs -o tls,accesspoint=${FS_AP_ID} ${FS_ID}:/ ${FOLDER}
echo "Este es el contenido de un fichero obtenido desde EFS: $(cat ${FOLDER}/${FILE} ) "         >> /var/www/html/index.html
