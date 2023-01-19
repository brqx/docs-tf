#!/bin/sh
# v.0.0.2 - 24-08-2022
# Ajustar la instancia para usar el puerto 60022
#sed -i "s/\#Port\ 22/Port 60022/g" /etc/ssh/sshd_config

# Only for fargate - Usamos host
# no funciona

# Get metadata fargate

#curl 169.254.170.2/v2/metadata # --> Only Fargate

#host google.com
#ip a | grep inet | grep eth0   # --> docker
#ip a | grep inet | grep eth1   # --> fargate

# curl --connect-timeout 2 169.254.170.2/v2/metadata
# NET_S=$?

#if [ ${NET_S} -eq 0 ] ; then
#fi

# Test montaje EFS
df -h | grep efs > /tmp/efs_01_00


service sshd status
SSH_S=$?

if [ ${SSH_S} -ne 0 ] ; then
service sshd start
fi

/sbin/service php-fpm start
/usr/sbin/nginx


# 保持前台运行，不退出
cont=0
while true
do
    sleep 10
    df -h | grep efs > /tmp/efs_01_${cont}
    cont=$(expr $cont + 1)
    netstat -an | grep LISTEN | grep 8080
    NET_S=$?
    if [ ${NET_S} -ne 0 ] ; then
    service nginx restart
    fi
done


