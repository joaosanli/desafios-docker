# Desafio 2: Persistência de Dados com Volumes

## Visão Geral

App Flask com banco de dados SQLite. Os dados vivem em um volume Docker, então sobrevivem aos restarts do container.

## Arquitetura

**App** (Flask + SQLite)
- Gerencia usuários em um banco de dados SQLite
- Arquivo do banco armazenado em `/data` (volume montado)
- Endpoints para operações CRUD

**Volume**
- Volume nomeado `db-storage`
- Montado em `/data` dentro do container
- Persiste através do ciclo de vida do container

## Como Funciona

```
Primeira execução:
  Container inicia → Banco inicializado → Dados inseridos → Volume criado

Container para:
  Dados no volume são preservados

Container reinicia:
  Volume remontado → Dados antigos disponíveis → App continua
```

## Executando

```bash
cd desafio2
chmod +x test.sh
./test.sh
```

Ou passo a passo:

```bash
docker-compose build
docker-compose up -d
sleep 3

# Adicionar um usuário
curl -X POST http://localhost:5000/users \
  -H "Content-Type: application/json" \
  -d '{"name": "Eve", "email": "eve@example.com"}'

# Parar e reiniciar
docker-compose down
docker-compose up -d
sleep 3

# Usuário deve estar lá
curl http://localhost:5000/users
```

## Endpoints

- `GET /users` - Listar todos os usuários
- `POST /users` - Adicionar usuário (JSON: `{name, email}`)
- `GET /db-info` - Informações do arquivo do banco

## Limpeza

```bash
# Parar containers (mantém volume)
docker-compose down

# Parar e remover volume
docker-compose down -v
```

## Conceitos-Chave

- Volumes Docker
- Persistência de dados
- Ciclo de vida do container
- SQLite
