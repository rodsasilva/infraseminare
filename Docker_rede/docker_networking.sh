#!/bin/bash

# Criar a rede DB
docker network create --driver bridge --internal DB

# Criar o container do banco de dados na rede DB
docker run -d --name db_container --network DB \
  -e MYSQL_ROOT_PASSWORD=senha_segura \
  mysql:latest

# Criar um container de aplicação em outra rede
docker network create app_network
docker run -d --name app_container --network app_network \
  nginx:latest

# Conectar o container de aplicação à rede DB
docker network connect DB app_container

# Configurar regras de firewall no container do banco de dados
# Permitir apenas conexões na porta 3306 do container de aplicação
DB_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' db_container)
APP_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' app_container)

docker exec db_container /bin/sh -c "
  apt-get update && apt-get install -y iptables
  iptables -A INPUT -p tcp --dport 3306 -s $APP_IP -j ACCEPT
  iptables -A INPUT -j DROP
"

# Testar a conexão
docker exec app_container ping -c 2 db_container
docker exec app_container mysql -h db_container -u root -psenha_segura -e "SHOW DATABASES;"