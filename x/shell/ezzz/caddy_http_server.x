#!/bin/bash
# Change SSH port
# Aws Starting Script for EC2 instance
# V.0.0.1 - Brqx Architectures - 2022_Aug
# ------------------------------------------------------------
# Vamos a ocultar el puerto con una variable
sed -i "s/\#Port\ 22/Port ${ssh_secret_port}/g" /etc/ssh/sshd_config
service sshd restart

# Python server
yum install yum-plugin-copr
yum copr enable @caddy/caddy
yum install caddy

caddy stop

# Proxy to 8000 python app
#

echo ${DOMAIN} > ./caddyfile

echo 'reverse_proxy localhost:8000 {' >> ./caddyfile'
echo '  header_up X-Forwarded-For {http.reverse_proxy.downstream.hostport}' >> ./caddyfile'
echo '  header_up Host {http.reverse_proxy.upstream.hostport}' >> ./caddyfile'
echo '}' >> ./caddyfile'

sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/caddy 


# REFS: 
# https://pancy.medium.com/running-a-https-python-server-on-ec2-in-5-minutes-6c1f0444a0cf
# https://caddyserver.com/
