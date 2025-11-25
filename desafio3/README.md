# Desafio 3: Orquestrando Múltiplos Serviços

## Visão Geral

Três serviços trabalhando juntos: uma app web, banco de dados PostgreSQL e cache Redis. Docker Compose gerencia dependências e networking.

## Arquitetura

**Web** (Flask)
- Porta 5000
- Conecta tanto ao DB quanto ao cache
- Endpoints: `/`, `/health`, `/data`, `/config`

**Banco de Dados** (PostgreSQL)
- Porta 5432 (interna)
- Volume persistente
- Health checks antes do web iniciar

**Cache** (Redis)
- Porta 6379 (interna)
- Persistência append-only
- Health checks antes do web iniciar

**Rede**
- Rede bridge nomeada `stack`
- Service discovery por hostname

## Como Funciona

```
App web inicia apenas após:
  ✓ PostgreSQL estar saudável
  ✓ Redis estar saudável

Quando /data é chamado:
  1. Verifica cache do Redis
  2. Se encontrado → retorna dados em cache
  3. Se não → consulta PostgreSQL
  4. Armazena em cache por 60 segundos
  5. Retorna dados
```

## Executando

```bash
cd desafio3
chmod +x test.sh
./test.sh
```

Ou manualmente:

```bash
docker-compose build
docker-compose up -d
sleep 5
curl http://localhost:5000/health
```

## Endpoints

- `GET /` - Status
- `GET /health` - Health check (mostra status do DB e cache)
- `GET /data` - Obter dados (com cache)
- `GET /config` - Mostrar configuração

## Acessando Serviços

```bash
# PostgreSQL do host
docker exec -it db psql -U postgres -d appdb

# Redis do host
docker exec -it cache redis-cli

# App web
curl http://localhost:5000/health
```

## Parando

```bash
docker-compose down
```

## Conceitos-Chave

- Orquestração de serviços
- Dependências entre serviços
- Health checks
- Service discovery
- Estratégia de cache
- Volumes persistentes
