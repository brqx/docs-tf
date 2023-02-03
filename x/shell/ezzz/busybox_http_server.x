#!/bin/bash
# Change SSH port
# Aws Starting Script for EC2 instance
# V.0.0.1 - Brqx Architectures - 2022_Aug
# ------------------------------------------------------------
# Vamos a ocultar el puerto con una variable
sed -i "s/\#Port\ 22/Port ${ssh_secret_port}/g" /etc/ssh/sshd_config
service sshd restart
# Server code in 8080 port
#!/bin/bash
echo "Hola Terraformers! Servidor 01" > index.html
nohup busybox httpd -f -p 8080 &
