#!/bin/bash
# Exercise E014
# Change SSH port
# Aws Starting Script for EC2 instance
# V.0.0.3 - Brqx Architectures - 2023_Feb
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
mkdir /existent_bucket  /new_bucket
s3fs ${EXISTENT_BUCKET} -o iam_role=${EC2_ROLE} -o use_cache=/tmp -o allow_other -o uid=${UID_EC2_USER} -o mp_umask=002 -o multireq_max=5 /existent_bucket

s3fs ${BUCKET} -o iam_role=${EC2_ROLE} -o use_cache=/tmp -o allow_other -o uid=${UID_EC2_USER} -o mp_umask=002 -o multireq_max=5 /new_bucket

echo "Este es el contenido de S3 obtenido desde un S3FS: $(cat /existent_bucket/${FOLDER}/${FILE} ) "         >> /var/www/html/index.html
echo "For ALB --> My IP is : $(curl http://169.254.169.254/latest/meta-data/local-ipv4) " >>  /var/www/html/index.html

