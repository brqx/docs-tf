#!/bin/bash
# Exercise E003
# Change SSH port
# Aws Starting Script for EC2 instance
# V.0.0.2 - Brqx Architectures - 2022_Aug
# ------------------------------------------------------------
# Vamos a ocultar el puerto con una variable
sed -i "s/\#Port\ 22/Port ${ssh_secret_port}/g" /etc/ssh/sshd_config
service sshd restart
# Server code
yum update -y
yum install -y httpd git
# Yum dependences
systemctl start httpd.service
systemctl enable httpd.service
echo "Hi Friend of brqx , I am $(hostname -f) hosted by Terraform" >  /var/www/html/index.html
## Mount EFS
# Si ponemos esto tarda un poco mas en iniciarse
# al iniciarse lo genera en el raiz. Montamos el sistema efs sin indicar el punto de montaje
mkdir /myefs
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${FS_ID}.efs.${REGION}.amazonaws.com:/ /myefs
echo "Este es el contenido de un fichero obtenido desde EFS: $(cat /myefs${FOLDER}/${FILE} ) "         >> /var/www/html/index.html
