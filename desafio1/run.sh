#!/bin/bash

set -e

echo "=== Challenge 1: Network Communication ==="
echo ""

docker-compose build
echo "✓ Built images"
echo ""

docker-compose up -d
echo "✓ Started containers"
echo ""

sleep 3

echo "Network status:"
docker network inspect $(docker-compose ps -q web-server | head -1 | xargs docker inspect --format='{{json .HostConfig.NetworkMode}}' 2>/dev/null || echo "local") 2>/dev/null | grep -A 5 Containers || echo "Network info not available"

echo ""
echo "Server logs:"
docker logs web-server | tail -3

echo ""
echo "Client logs (waiting 10s):"
sleep 10
docker logs http-client | head -15

echo ""
echo "✓ Challenge 1 is running"
echo ""
echo "To stop: docker-compose down"
echo "To see logs: docker-compose logs -f"
