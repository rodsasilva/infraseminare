# Procedimento

```bash
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

```

Nesta configuração atualizada, criamos um perímetro de segurança mais robusto:

1. Rede DB: Totalmente isolada, contendo apenas o container do banco de dados.

2. Rede de Aplicação: Separada da rede DB, contendo o container da aplicação.

3. Container Proxy: Age como um firewall/gateway entre as duas redes.

Principais características:

- O container do banco de dados (172.18.0.2) só aceita conexões do proxy (172.18.0.3).
- O proxy (172.19.0.3 na rede da aplicação, 172.18.0.3 na rede DB) encaminha apenas o tráfego MySQL.
- A aplicação (172.19.0.2) só pode acessar o banco através do proxy.
- Usamos IPs fixos para maior controle.

Benefícios desta abordagem:

1. Isolamento: O banco de dados está completamente isolado da rede externa.
2. Controle de Acesso: Apenas tráfego MySQL específico é permitido.
3. Logging e Monitoramento: O proxy pode ser usado para registrar e monitorar o tráfego.
4. Flexibilidade: Facilita a implementação de políticas de segurança adicionais no proxy.

Para usar esta configuração:

1. Salve o script como `setup_secure_db_network.sh`.
2. Torne-o executável: `chmod +x setup_secure_db_network.sh`.
3. Execute: `./setup_secure_db_network.sh`.

Lembre-se de que este é um exemplo e pode precisar de ajustes baseados em suas necessidades específicas de segurança e na arquitetura da sua aplicação. Por exemplo, você pode querer adicionar autenticação TLS, implementar rate limiting no proxy, ou configurar backups seguros.

Você gostaria de discutir algum aspecto específico desta configuração ou tem alguma pergunta sobre como adaptá-la às suas necessidades?