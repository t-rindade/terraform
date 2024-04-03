#!/bin/bash

apt-get update
apt-get install -y docker.io git

git clone https://github.com/FofuxoSibov/sitebike.git /var/www/html/

cat << EOF > /var/www/html/Dockerfile
FROM nginx:latest
COPY . /usr/share/nginx/html
EOF

docker build -t imagemsitebike /var/www/html/
docker run -d -p 80:80 imagemsitebike