#!/bin/bash

set -e

echo "=== Challenge 5: API Gateway Pattern ==="
echo ""

docker-compose build
echo "✓ Built images"
echo ""

docker-compose up -d
echo "✓ Started services"
echo ""

sleep 5

echo "Gateway health:"
curl -s http://localhost:5000/health | python3 -m json.tool
echo ""

echo "Users (via gateway):"
curl -s http://localhost:5000/users | python3 -m json.tool | head -15
echo ""

echo "Orders (via gateway):"
curl -s http://localhost:5000/orders | python3 -m json.tool | head -15
echo ""

echo "User 1 profile (aggregated):"
curl -s http://localhost:5000/user/1/profile | python3 -m json.tool
echo ""

echo "Dashboard:"
curl -s http://localhost:5000/dashboard | python3 -m json.tool
echo ""

echo "✓ Gateway routing all requests"
echo ""
echo "To stop: docker-compose down"
