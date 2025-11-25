# Desafio 5: API Gateway

## Visão Geral

Padrão API Gateway: ponto de entrada único (porta 5000) roteia requisições para microsserviços internos (usuários e pedidos). Clientes nunca acessam serviços diretamente.

## Arquitetura

**Gateway** (porta 5000)
- Ponto de entrada público
- Roteia requisições para serviços
- Agrega dados de múltiplos serviços
- Health checks de todos os serviços

**Serviço de Usuários** (porta 5003, interno)
- Fornece dados de usuários
- Não exposto externamente
- Acessado apenas via gateway

**Serviço de Pedidos** (porta 5004, interno)
- Fornece dados de pedidos
- Não exposto externamente
- Acessado apenas via gateway

**Rede**
- Rede bridge
- Apenas gateway tem porta externa
- Serviços se comunicam internamente

## Como Funciona

```
Requisição do cliente
    ↓
Gateway (5000) - público
    ↓
    Roteia para serviços internos
    ↓
Usuários (5003) e Pedidos (5004) - privados
    ↓
Gateway agrega resposta
    ↓
Retorna ao cliente
```

## Executando

```bash
cd desafio5
chmod +x test.sh
./test.sh
```

Ou manualmente:

```bash
docker-compose build
docker-compose up -d
sleep 5

# Todas as requisições passam pelo gateway
curl http://localhost:5000/users
curl http://localhost:5000/orders
curl http://localhost:5000/user/1/profile
curl http://localhost:5000/dashboard
```

## Endpoints

Todos via gateway (porta 5000):

- `GET /users` - Listar usuários
- `GET /users/<id>` - Usuário único
- `GET /orders` - Listar pedidos
- `GET /orders/<id>` - Pedido único
- `GET /user/<id>/orders` - Pedidos do usuário
- `GET /user/<id>/profile` - Usuário + pedidos
- `GET /dashboard` - Estatísticas
- `GET /health` - Health check do gateway

## Conceitos-Chave

- Padrão API Gateway
- Ponto de entrada único
- Isolamento de serviços
- Roteamento de requisições
- Agregação de dados
- Service discovery
