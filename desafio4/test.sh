#!/bin/bash

set -e

echo "=== Challenge 4: Independent Microservices ==="
echo ""

docker-compose build
echo "✓ Built images"
echo ""

docker-compose up -d
echo "✓ Started services"
echo ""

sleep 5

echo "Testing users service (port 5001, internal):"
docker exec consumer curl -s http://users:5001/users | python3 -m json.tool | head -20
echo ""

echo "Testing consumer service (port 5002, external):"
curl -s http://localhost:5002/users-enriched | python3 -m json.tool | head -20
echo ""

echo "Summary:"
curl -s http://localhost:5002/summary | python3 -m json.tool
echo ""

echo "✓ Services communicating"
echo ""
echo "To stop: docker-compose down"
