# Makefile for Security Monitoring Agent System

.PHONY: help setup build up down restart logs clean test

# Default target
help:
	@echo "Security Monitoring Agent System - Docker Commands"
	@echo ""
	@echo "Available commands:"
	@echo "  make setup      - Initial setup (copy .env and install)"
	@echo "  make build      - Build all Docker images"
	@echo "  make up         - Start all services"
	@echo "  make down       - Stop all services"
	@echo "  make restart    - Restart all services"
	@echo "  make logs       - View all logs"
	@echo "  make clean      - Clean up containers and volumes"
	@echo "  make test       - Run tests"
	@echo "  make shell-backend  - Open backend shell"
	@echo "  make shell-frontend - Open frontend shell"
	@echo "  make db-backup  - Backup MongoDB data"
	@echo "  make db-restore - Restore MongoDB data"

# Setup
setup:
	@echo "Setting up environment..."
	@if not exist .env (copy .env.docker .env)
	@echo "Please edit .env and add your OPENAI_API_KEY"

# Build
build:
	@echo "Building Docker images..."
	docker-compose build

# Start services
up:
	@echo "Starting all services..."
	docker-compose up -d
	@echo "Services started!"
	@echo "Frontend: http://localhost:3000"
	@echo "Backend API: http://localhost:8000"
	@echo "API Docs: http://localhost:8000/docs"

# Stop services
down:
	@echo "Stopping all services..."
	docker-compose down

# Restart services
restart:
	@echo "Restarting all services..."
	docker-compose restart

# View logs
logs:
	docker-compose logs -f

# View backend logs
logs-backend:
	docker-compose logs -f backend

# View frontend logs
logs-frontend:
	docker-compose logs -f frontend

# Clean up
clean:
	@echo "Cleaning up containers and volumes..."
	docker-compose down -v
	docker system prune -f

# Deep clean
clean-all:
	@echo "Deep cleaning (removes all images)..."
	docker-compose down -v
	docker system prune -a -f --volumes

# Backend shell
shell-backend:
	docker exec -it smas-backend bash

# Frontend shell
shell-frontend:
	docker exec -it smas-frontend sh

# MongoDB shell
shell-db:
	docker exec -it smas-mongodb mongosh

# Redis CLI
shell-redis:
	docker exec -it smas-redis redis-cli

# Backup MongoDB
db-backup:
	@echo "Backing up MongoDB..."
	@if not exist backup mkdir backup
	docker exec smas-mongodb mongodump --out=/data/backup
	docker cp smas-mongodb:/data/backup ./backup/mongodb

# Restore MongoDB
db-restore:
	@echo "Restoring MongoDB..."
	docker cp ./backup/mongodb smas-mongodb:/data/backup
	docker exec smas-mongodb mongorestore /data/backup

# Run tests
test:
	@echo "Running tests..."
	docker-compose exec backend pytest

# Check status
status:
	docker-compose ps

# Quick rebuild
rebuild:
	docker-compose up -d --build

# Production deployment
deploy-prod:
	@echo "Deploying to production..."
	docker-compose --profile production up -d --build

# View stats
stats:
	docker stats

# Install (build and start)
install: setup build up
	@echo "Installation complete!"
	@echo "Access the dashboard at http://localhost:3000"
