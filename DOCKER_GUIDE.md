# 🐳 Docker Deployment Guide

Complete guide to run Security Monitoring Agent System with Docker.

## 📋 Prerequisites

### Install Docker Desktop

**Windows:**
1. Download Docker Desktop from https://www.docker.com/products/docker-desktop
2. Install and restart computer
3. Verify installation:
```bash
docker --version
docker-compose --version
```

**Linux:**
```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify
docker --version
docker-compose --version
```

**Mac:**
1. Install Docker Desktop from https://www.docker.com/products/docker-desktop
2. Verify installation:
```bash
docker --version
docker-compose --version
```

## 🚀 Quick Start (3 Steps)

### Step 1: Configure Environment

```bash
cd C:\Users\Admin\Desktop\agent

# Copy environment file
cp .env.docker .env

# Edit .env and add your OpenAI API key
# Windows: notepad .env
# Linux/Mac: nano .env
```

**Minimum required in `.env`:**
```bash
OPENAI_API_KEY=sk-your-actual-openai-key-here
SECRET_KEY=change-this-to-random-secret
```

### Step 2: Build & Start All Services

```bash
# Build and start all containers
docker-compose up -d --build

# This will:
# 1. Build backend image
# 2. Build frontend image
# 3. Pull MongoDB image
# 4. Pull Redis image
# 5. Start all services
```

**Wait 1-2 minutes for first build...**

### Step 3: Access Application

- **Frontend Dashboard**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **API Documentation**: http://localhost:8000/docs

Done! 🎉

## 🎯 Docker Commands

### Start Services

```bash
# Start all services
docker-compose up -d

# Start specific service
docker-compose up -d backend
docker-compose up -d frontend

# Start with logs
docker-compose up
```

### Stop Services

```bash
# Stop all services
docker-compose down

# Stop and remove volumes (reset data)
docker-compose down -v

# Stop specific service
docker-compose stop backend
```

### View Logs

```bash
# View all logs
docker-compose logs

# View specific service logs
docker-compose logs backend
docker-compose logs frontend
docker-compose logs mongodb

# Follow logs (live)
docker-compose logs -f backend

# Last 100 lines
docker-compose logs --tail=100 backend
```

### Restart Services

```bash
# Restart all services
docker-compose restart

# Restart specific service
docker-compose restart backend
docker-compose restart frontend
```

### Rebuild Services

```bash
# Rebuild and restart all
docker-compose up -d --build

# Rebuild specific service
docker-compose up -d --build backend
```

### Check Status

```bash
# List running containers
docker-compose ps

# Check service health
docker-compose ps
docker exec smas-backend curl http://localhost:8000/
```

## 📊 Container Details

### Services

| Service | Port | Description |
|---------|------|-------------|
| **backend** | 8000 | FastAPI backend with AI agents |
| **frontend** | 3000 | React dashboard |
| **mongodb** | 27017 | Database |
| **redis** | 6379 | Cache & message queue |
| **nginx** | 80, 443 | Reverse proxy (optional) |

### Volumes

```bash
# List volumes
docker volume ls

# Inspect volume
docker volume inspect agent_mongodb_data
docker volume inspect agent_redis_data
docker volume inspect agent_backend_logs
```

### Networks

```bash
# List networks
docker network ls

# Inspect network
docker network inspect agent_smas-network
```

## 🔧 Troubleshooting

### Container Won't Start

**Check logs:**
```bash
docker-compose logs backend
docker-compose logs frontend
```

**Common issues:**

1. **Port already in use**
```bash
# Find process using port
# Windows:
netstat -ano | findstr :8000
# Linux/Mac:
lsof -i :8000

# Kill process or change port in docker-compose.yml
```

2. **Missing environment variables**
```bash
# Check if .env exists
cat .env

# Verify OpenAI key is set
docker-compose config | grep OPENAI_API_KEY
```

3. **Permission denied (Linux)**
```bash
# Add user to docker group
sudo usermod -aG docker $USER
# Logout and login again
```

### Network Monitoring Not Working

The backend container needs special privileges:

```yaml
# Already configured in docker-compose.yml
cap_add:
  - NET_ADMIN
  - NET_RAW
privileged: true
```

**If still not working:**
```bash
# Run with host network (Linux only)
docker-compose -f docker-compose.override.yml up
```

### Database Connection Failed

**Check MongoDB:**
```bash
# Check if MongoDB is running
docker-compose ps mongodb

# Check MongoDB logs
docker-compose logs mongodb

# Connect to MongoDB shell
docker exec -it smas-mongodb mongosh
```

### Redis Connection Failed

**Check Redis:**
```bash
# Check if Redis is running
docker-compose ps redis

# Test Redis connection
docker exec -it smas-redis redis-cli ping
# Should return: PONG
```

### Frontend Can't Connect to Backend

**Check network connectivity:**
```bash
# From frontend container
docker exec -it smas-frontend wget http://backend:8000/

# Check if backend is responding
curl http://localhost:8000/
```

**Update environment:**
```bash
# In .env
VITE_API_URL=http://localhost:8000
VITE_WS_URL=ws://localhost:8000

# Rebuild frontend
docker-compose up -d --build frontend
```

## 🔄 Update & Maintenance

### Update Application

```bash
# Pull latest changes
git pull

# Rebuild and restart
docker-compose down
docker-compose up -d --build
```

### Backup Data

```bash
# Backup MongoDB
docker exec smas-mongodb mongodump --out=/data/backup
docker cp smas-mongodb:/data/backup ./backup

# Backup Redis
docker exec smas-redis redis-cli SAVE
docker cp smas-redis:/data/dump.rdb ./backup/redis-dump.rdb

# Backup logs
docker cp smas-backend:/app/logs ./backup/logs
```

### Restore Data

```bash
# Restore MongoDB
docker cp ./backup smas-mongodb:/data/backup
docker exec smas-mongodb mongorestore /data/backup

# Restore Redis
docker cp ./backup/redis-dump.rdb smas-redis:/data/dump.rdb
docker-compose restart redis
```

### Clean Up

```bash
# Remove stopped containers
docker-compose rm

# Remove unused images
docker image prune -a

# Remove unused volumes
docker volume prune

# Full cleanup (DANGER: removes all data)
docker-compose down -v
docker system prune -a --volumes
```

## 🚀 Production Deployment

### With Nginx (Recommended)

```bash
# Start with nginx profile
docker-compose --profile production up -d

# Access via nginx
# http://localhost (port 80)
```

### Environment Variables for Production

```bash
# Update .env for production
DEBUG=False
ENABLE_ATTACK_SIM=False  # Disable attack sim in production

# Use strong secrets
SECRET_KEY=$(openssl rand -hex 32)
```

### SSL/HTTPS Setup

1. Get SSL certificate (Let's Encrypt recommended)

```bash
# Using certbot
sudo certbot certonly --standalone -d your-domain.com
```

2. Copy certificates to nginx/ssl/

```bash
mkdir -p nginx/ssl
cp /etc/letsencrypt/live/your-domain.com/fullchain.pem nginx/ssl/cert.pem
cp /etc/letsencrypt/live/your-domain.com/privkey.pem nginx/ssl/key.pem
```

3. Update nginx.conf (uncomment HTTPS section)

4. Restart nginx

```bash
docker-compose restart nginx
```

## 📊 Monitoring

### Container Stats

```bash
# Real-time stats
docker stats

# Specific container
docker stats smas-backend
```

### Health Checks

```bash
# Check all containers health
docker-compose ps

# Manual health check
docker exec smas-backend curl http://localhost:8000/
docker exec smas-frontend wget -q -O- http://localhost:3000/
```

### Resource Usage

```bash
# Disk usage
docker system df

# Container logs size
docker-compose logs --tail=1 backend 2>&1 | wc -c
```

## 🐛 Debug Mode

### Access Container Shell

```bash
# Backend container
docker exec -it smas-backend bash

# Frontend container
docker exec -it smas-frontend sh

# MongoDB container
docker exec -it smas-mongodb mongosh

# Redis container
docker exec -it smas-redis redis-cli
```

### Run Commands Inside Container

```bash
# Python shell in backend
docker exec -it smas-backend python

# Check processes
docker exec smas-backend ps aux

# Test network
docker exec smas-backend ping mongodb
```

## 🎯 Quick Commands Reference

```bash
# Start everything
docker-compose up -d

# View logs
docker-compose logs -f

# Restart
docker-compose restart

# Stop everything
docker-compose down

# Rebuild
docker-compose up -d --build

# Clean up
docker-compose down -v && docker system prune -a
```

## 📈 Performance Optimization

### Resource Limits

Add to docker-compose.yml:

```yaml
services:
  backend:
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 2G
        reservations:
          cpus: '1'
          memory: 1G
```

### Build Cache

```bash
# Use BuildKit for faster builds
DOCKER_BUILDKIT=1 docker-compose build

# Clear build cache
docker builder prune
```

## 🆘 Get Help

- Check logs: `docker-compose logs`
- Container status: `docker-compose ps`
- Backend health: http://localhost:8000/docs
- Frontend: http://localhost:3000

---

**🎉 Docker deployment complete! Your security monitoring system is running in containers!**
