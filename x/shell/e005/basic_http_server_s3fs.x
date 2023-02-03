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
yum install -y automake fuse fuse-devel gcc-c++ libcurl-devel libxml2-devel make openssl-devel
systemctl start httpd.service
systemctl enable httpd.service
echo "Hi Friend of brqx , I am $(hostname -f) hosted by Terraform" >  /var/www/html/index.html
## Mount S3FS
# Si ponemos esto tarda un poco mas en iniciarse
# al iniciarse lo genera en el raiz
git clone https://github.com/s3fs-fuse/s3fs-fuse.git
#
cd s3fs-fuse
./autogen.sh
./configure --prefix=/usr --with-openssl
make
make install
#
mkdir /mys3bucket
s3fs ${BUCKET} -o iam_role=${EC2_ROLE} -o use_cache=/tmp -o allow_other -o uid=${UID_EC2_USER} -o mp_umask=002 -o multireq_max=5 /mys3bucket
echo "Este es el contenido de S3 obtenido desde un S3FS: $(cat /mys3bucket/${FOLDER}/${FILE} ) "         >> /var/www/html/index.html
