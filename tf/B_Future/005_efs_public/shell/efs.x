#!/bin/bash
#yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
#systemctl start amazon-ssm-agent
mkdir -p ${mount_path}
yum install -y amazon-efs-utils
mount -t efs -o iam,tls ${efs_id} ${mount_path}
echo "${efs_id} ${mount_path} efs _netdev,tls,iam 0 0" >> /etc/fstab
# Creating demo content for other services
mkdir -p ${mount_path}/fargate
mkdir -p ${mount_path}/lambda
df -h > ${mount_path}/fargate/demo.txt
df -h > ${mount_path}/lambda/demo.txt
chown ec2-user:ec2-user -R ${mount_path}
