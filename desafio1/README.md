# Desafio 1: Comunicação entre Containers

## Visão Geral

Dois containers se comunicam através de uma rede Docker customizada. O servidor expõe endpoints HTTP, e o cliente faz requisições periódicas para verificar a conectividade.

## Arquitetura

**Servidor** (Flask)
- Escuta na porta 8080
- Endpoints: `/` e `/health`
- Responde com JSON

**Cliente** (Alpine + curl)
- Faz requisições HTTP a cada 5 segundos
- Alvo: `http://web-server:8080`
- Usa hostname do container para service discovery

**Rede**
- Driver bridge
- Ambos os containers conectados
- Resolução de hostname automática

## Como Funciona

O Docker resolve o hostname `web-server` para o IP do container. Sem necessidade de IPs explícitos.

```
Container cliente
    ↓
curl http://web-server:8080/
    ↓
DNS do Docker resolve "web-server" → IP do container
    ↓
Container servidor responde
```

## Executando

```bash
cd desafio1
chmod +x run.sh
./run.sh
```

Ou manualmente:

```bash
docker-compose build
docker-compose up -d
sleep 3
docker logs http-client
```

## Testando

Verificar se os containers estão se comunicando:

```bash
docker exec http-client curl http://web-server:8080/
```

Inspecionar a rede:

```bash
docker network inspect $(docker network ls | grep local | awk '{print $1}')
```

## Parando

```bash
docker-compose down
```

## Conceitos-Chave

- Redes Docker bridge
- Service discovery via hostname
- Health checks
- Dependências entre containers
