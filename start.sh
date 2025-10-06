#!/bin/bash
# Start script for Security Monitoring Agent System

set -e

echo "🐳 Security Monitoring Agent System - Docker Setup"
echo "=================================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed!"
    echo "Please install Docker Desktop from: https://www.docker.com/products/docker-desktop"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed!"
    echo "Please install Docker Compose"
    exit 1
fi

echo "✅ Docker is installed"
echo "✅ Docker Compose is installed"
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.docker .env
    echo ""
    echo "⚠️  IMPORTANT: Please edit .env and add your OPENAI_API_KEY"
    echo ""
    read -p "Press Enter after you've added your API key to .env..."
fi

# Verify API key is set
if ! grep -q "sk-" .env; then
    echo "❌ OpenAI API key not found in .env"
    echo "Please edit .env and add: OPENAI_API_KEY=sk-your-key-here"
    exit 1
fi

echo "🔨 Building Docker images..."
docker-compose build

echo ""
echo "🚀 Starting services..."
docker-compose up -d

echo ""
echo "⏳ Waiting for services to be ready..."
sleep 5

# Check if services are running
if docker-compose ps | grep -q "Up"; then
    echo ""
    echo "✅ All services are running!"
    echo ""
    echo "📊 Access points:"
    echo "  - Frontend Dashboard: http://localhost:3000"
    echo "  - Backend API:        http://localhost:8000"
    echo "  - API Documentation:  http://localhost:8000/docs"
    echo ""
    echo "📝 Useful commands:"
    echo "  - View logs:    docker-compose logs -f"
    echo "  - Stop all:     docker-compose down"
    echo "  - Restart:      docker-compose restart"
    echo ""
else
    echo "❌ Some services failed to start"
    echo "Check logs with: docker-compose logs"
    exit 1
fi
