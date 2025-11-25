# Docker & Microsserviços - Desafios

Cinco desafios progressivos cobrindo Docker básico até arquitetura de microsserviços.

## Desafios

### Desafio 1: Comunicação em Rede
Dois containers conversando através de uma rede Docker customizada.

```bash
cd desafio1 && chmod +x run.sh && ./run.sh
```

**Conceitos**: Networking, service discovery, health checks

---

### Desafio 2: Persistência de Dados
App Flask com SQLite em um volume Docker. Dados sobrevivem aos restarts do container.

```bash
cd desafio2 && chmod +x test.sh && ./test.sh
```

**Conceitos**: Volumes, persistência, ciclo de vida do container

---

### Desafio 3: Stack Multi-Serviço
App web + PostgreSQL + Redis orquestrados com Docker Compose.

```bash
cd desafio3 && chmod +x test.sh && ./test.sh
```

**Conceitos**: Orquestração, dependências, cache, service discovery

---

### Desafio 4: Microsserviços
Dois serviços independentes: um fornece dados, outro consome e enriquece.

```bash
cd desafio4 && chmod +x test.sh && ./test.sh
```

**Conceitos**: Microsserviços, comunicação HTTP, enriquecimento de dados

---

### Desafio 5: API Gateway
Ponto de entrada único roteando para microsserviços internos.

```bash
cd desafio5 && chmod +x test.sh && ./test.sh
```

**Conceitos**: Padrão Gateway, roteamento, agregação, isolamento

---

## Começando Rápido

Requisitos: Docker 20.10+, Docker Compose 1.29+

Cada desafio é independente. Execute qualquer um:

```bash
cd desafioX
chmod +x test.sh run.sh 2>/dev/null
./test.sh  # ou ./run.sh para desafio 1
```

## Estrutura

```
desafios-docker/
├── desafio1/     # Networking
├── desafio2/     # Persistência
├── desafio3/     # Orquestração
├── desafio4/     # Microsserviços
├── desafio5/     # API Gateway
└── README.md
```

Cada desafio tem:
- Dockerfile(s)
- docker-compose.yml
- test.sh / run.sh
- README.md

## Conceitos-Chave

- Networking de containers
- Persistência de dados
- Orquestração de serviços
- Arquitetura de microsserviços
- Padrão API Gateway
- Service discovery
- Health checks
- Dependências entre containers

## Notas

- Cada serviço é auto-contido
- Sem dependências externas
- Todos os dados em memória ou em volumes
- Health checks em todos os serviços
- Tratamento de erros apropriado
