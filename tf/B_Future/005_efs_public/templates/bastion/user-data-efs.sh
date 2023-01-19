#!/bin/bash
# Change SSH port
# Enable EFS
# Install Docker
# Aws Starting Script for EC2 instance
# V.0.0.1 - Brqx Architectures - 2022_Aug
# ------------------------------------------------------------
sed -i "s/\#Port\ 22/Port 60022/g" /etc/ssh/sshd_config
service sshd restart

# Enable EFS

mkdir -p ${local.ec2_file_system_local_mount_path}
yum install -y amazon-efs-utils
mount -t efs -o iam,tls ${local.efs_id} ${local.ec2_file_system_local_mount_path}
echo "${local.efs_id} ${local.ec2_file_system_local_mount_path} efs _netdev,tls,iam 0 0" >> /etc/fstab
# Creating demo content for other services
mkdir -p ${local.ec2_file_system_local_mount_path}/fargate
mkdir -p ${local.ec2_file_system_local_mount_path}/lambda
df -h > ${local.ec2_file_system_local_mount_path}/fargate/demo.txt
df -h > ${local.ec2_file_system_local_mount_path}/lambda/demo.txt
chown ec2-user:ec2-user -R ${local.ec2_file_system_local_mount_path}

# Install Docker
sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker ec2-user
