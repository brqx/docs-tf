#!/bin/bash
# Change SSH port
# Aws Starting Script for EC2 instance
# V.0.0.2 - Brqx Architectures - 2022_Aug
# ------------------------------------------------------------
# Vamos a ocultar el puerto con una variable
sed -i "s/\#Port\ 22/Port ${ssh_secret_port}/g" /etc/ssh/sshd_config
service sshd restart
# Server code
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
echo "Hi Friend of brqx , I am $(hostname -f) hosted by Terraform" >  /var/www/html/index.html
## Access to S3
# Si ponemos esto tarda un poco mas en iniciarse
aws s3 cp s3://${BUCKET}/${FOLDER}/${FILE} /tmp/tmp_s3_file
# Tarda unos segundo mas al coneccarse a S3. El fichero ha desaparecido cuando entramos luego
echo "Este es el contenido de S3: $(cat /tmp/tmp_s3_file ) "         >> /var/www/html/index.html
