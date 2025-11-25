# Desafio 4: Microsserviços Independentes

## Visão Geral

Dois serviços separados: um fornece dados de usuários, o outro consome e enriquece esses dados.

## Arquitetura

**Serviço de Usuários** (porta 5001)
- Fornece dados de usuários via REST API
- Sem dependências externas
- Endpoints: `/users`, `/users/<id>`, `/users/status/<status>`

**Serviço Consumidor** (porta 5002)
- Chama o serviço de usuários
- Enriquece dados com campos computados
- Endpoints: `/users-enriched`, `/summary`

**Rede**
- Rede bridge
- Serviços se comunicam por hostname

## Como Funciona

```
Consumidor faz requisição HTTP:
  GET http://users:5001/users
    ↓
  DNS do Docker resolve "users" → IP do container
    ↓
  Serviço de usuários responde
    ↓
  Consumidor processa e enriquece dados
    ↓
  Retorna ao cliente
```

## Executando

```bash
cd desafio4
chmod +x test.sh
./test.sh
```

Ou manualmente:

```bash
docker-compose build
docker-compose up -d
sleep 5

# Serviço de usuários (de dentro do consumidor)
docker exec consumer curl http://users:5001/users

# Serviço consumidor (do host)
curl http://localhost:5002/users-enriched
curl http://localhost:5002/summary
```

## Endpoints

**Serviço de Usuários**
- `GET /users` - Todos os usuários
- `GET /users/<id>` - Usuário único
- `GET /users/status/<status>` - Filtrar por status

**Serviço Consumidor**
- `GET /users-enriched` - Usuários com campos extras
- `GET /summary` - Estatísticas agregadas

## Conceitos-Chave

- Separação de microsserviços
- Comunicação HTTP
- Enriquecimento de dados
- Service discovery
- Networking de containers
