#!/bin/bash
# Example File for E002 Exercise
# --==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
# Change SSH port
# Aws Starting Script for EC2 instance
# V.0.0.2 - Brqx Architectures - 2022_Aug
# ------------------------------------------------------------
# Vamos a ocultar el puerto con una variable
sed -i "s/\#Port\ 22/Port ${ssh_secret_port}/g" /etc/ssh/sshd_config
service sshd restart
# Server code
yum update -y
yum install -y httpd jq
systemctl start httpd.service
systemctl enable httpd.service

echo "Hi Friend of brqx , I am $(hostname -f) hosted by Terraform </BR>" >  /var/www/html/index.html
echo "For ALB ONE Desktop --> My IP is : $(curl http://169.254.169.254/latest/meta-data/local-ipv4) " >>  /var/www/html/index.html
echo "We have SETCHANGE in queue </BR>" | tee -a /var/www/html/index.html
# Establecemos la plantilla que no se cambia
cp -f /var/www/html/index.html /tmp/tmp_file_sed

# No tiene sentido Pues siempre sera 0. Lo que intento hacer es una API
# Vamos a hacerlo con las conexiones ssh

echo 'aws sqs send-message --queue-url ${QUEUE_URL} --message-body "Soy instancia $(hostname -f)"  --region ${REGION}' >> /home/ec2-user/.bashrc
echo 'NUM_MSG=$(aws sqs get-queue-attributes --attribute-names ApproximateNumberOfMessages --queue-url ${QUEUE_URL}  --region ${REGION} | jq -r ".Attributes[]" )'  >> /home/ec2-user/.bashrc
echo 'sudo cp -f /tmp/tmp_file_sed  /var/www/html/index.html '         >> /home/ec2-user/.bashrc
echo 'sudo sed  -i "s/SETCHANGE/$${NUM_MSG}/g" /var/www/html/index.html '  >> /home/ec2-user/.bashrc

fi

