#!/bin/bash

set -e

echo "=== Challenge 3: Multi-Service Orchestration ==="
echo ""

docker-compose build
echo "✓ Built web image"
echo ""

docker-compose up -d
echo "✓ Started all services"
echo ""

sleep 5

docker-compose ps
echo ""

echo "Testing endpoints..."
echo ""

echo "1. Health check:"
curl -s http://localhost:5000/health | python3 -m json.tool
echo ""

echo "2. Config:"
curl -s http://localhost:5000/config | python3 -m json.tool
echo ""

echo "3. First data call (from DB):"
curl -s http://localhost:5000/data | python3 -m json.tool
echo ""

echo "4. Second data call (from cache):"
sleep 1
curl -s http://localhost:5000/data | python3 -m json.tool
echo ""

echo "Services running:"
docker-compose logs --tail=3 web
echo ""

echo "✓ All services working"
echo ""
echo "To stop: docker-compose down"
echo "To see logs: docker-compose logs -f"
