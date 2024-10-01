#!/bin/bash

# Criar a rede DB (totalmente isolada)
docker network create --driver bridge --internal --subnet 172.18.0.0/16 DB

# Criar uma rede para a aplicação
docker network create --driver bridge --subnet 172.19.0.0/16 app_network

# Criar o container do banco de dados na rede DB
docker run -d --name db_container --network DB \
  --ip 172.18.0.2 \
  -e MYSQL_ROOT_PASSWORD=senha_segura \
  mysql:latest

# Criar o container de aplicação na rede app_network
docker run -d --name app_container --network app_network \
  --ip 172.19.0.2 \
  nginx:latest

# Criar um container proxy/firewall para intermediar as conexões
docker run -d --name proxy_container \
  --network app_network \
  --ip 172.19.0.3 \
  nginx:latest

# Conectar o proxy à rede DB
docker network connect --ip 172.18.0.3 DB proxy_container

# Configurar o proxy para encaminhar conexões MySQL
docker exec proxy_container /bin/sh -c "
  apt-get update && apt-get install -y nginx
  echo 'stream {
    server {
        listen 3306;
        proxy_pass db_container:3306;
    }
  }' > /etc/nginx/nginx.conf
  nginx -s reload
"

# Configurar regras de firewall no container do banco de dados
docker exec db_container /bin/sh -c "
  apt-get update && apt-get install -y iptables
  iptables -A INPUT -p tcp --dport 3306 -s 172.18.0.3 -j ACCEPT
  iptables -A INPUT -j DROP
"

# Configurar regras de firewall no container proxy
docker exec proxy_container /bin/sh -c "
  apt-get install -y iptables
  iptables -A FORWARD -p tcp --dport 3306 -s 172.19.0.2 -d 172.18.0.2 -j ACCEPT
  iptables -A FORWARD -j DROP
"

# Teste de conexão (ajuste conforme necessário para sua aplicação real)
docker exec app_container /bin/sh -c "
  apt-get update && apt-get install -y mysql-client
  mysql -h 172.19.0.3 -P 3306 -u root -psenha_segura -e 'SHOW DATABASES;'
"