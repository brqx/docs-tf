#!/bin/bash
echo "Hola Terraformers!" > index.html
nohup busybox httpd -f -p 8080 &
EOF
