#!/bin/bash
# Change SSH port
# Aws Starting Script for EC2 instance
# V.0.0.1 - Brqx Architectures - 2022_Aug
# ------------------------------------------------------------
sed -i "s/\#Port\ 22/Port 60022/g" /etc/ssh/sshd_config
service sshd restart

sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker ec2-user
