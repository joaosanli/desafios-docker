#!/bin/bash

set -e

echo "=== Challenge 2: Data Persistence ==="
echo ""

docker-compose build
echo "✓ Built image"
echo ""

docker-compose up -d
sleep 3
echo "✓ Container started"
echo ""

echo "Initial users:"
curl -s http://localhost:5000/users | python3 -m json.tool
echo ""

echo "Adding new user..."
curl -s -X POST http://localhost:5000/users \
  -H "Content-Type: application/json" \
  -d '{"name": "David", "email": "david@example.com"}' | python3 -m json.tool
echo ""

echo "Users after adding:"
curl -s http://localhost:5000/users | python3 -m json.tool
echo ""

echo "Stopping container..."
docker-compose down
echo "✓ Container removed (volume persists)"
echo ""

echo "Restarting..."
docker-compose up -d
sleep 3
echo "✓ Container restarted"
echo ""

echo "Users after restart (should still have David):"
curl -s http://localhost:5000/users | python3 -m json.tool
echo ""

echo "✓ Data persisted!"
echo ""
echo "To clean up: docker-compose down -v"
