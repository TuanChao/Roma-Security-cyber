# 🐳 Security Monitoring Agent System - Docker Edition

Complete containerized security monitoring platform with AI-powered threat analysis.

## 🚀 Quick Start (Windows)

### 1. Double-click `start.bat`

That's it! The script will:
- ✅ Check Docker installation
- ✅ Create .env file
- ✅ Build all containers
- ✅ Start all services

### 2. Configure API Key

When prompted, edit `.env` and add your OpenAI API key:

```bash
OPENAI_API_KEY=sk-your-actual-key-here
```

### 3. Access Dashboard

Open browser: **http://localhost:3000**

## 🚀 Quick Start (Linux/Mac)

```bash
# Make script executable
chmod +x start.sh

# Run
./start.sh
```

## 🐳 What Gets Installed?

Docker will automatically set up:

```
┌─────────────────────────────────────┐
│  Security Monitoring System         │
├─────────────────────────────────────┤
│                                     │
│  🌐 Frontend (React)     :3000     │
│  🔧 Backend (FastAPI)    :8000     │
│  💾 MongoDB              :27017    │
│  🔴 Redis                :6379     │
│  🔒 Nginx (optional)     :80       │
│                                     │
└─────────────────────────────────────┘
```

## 📊 Services

| Service | Port | URL | Description |
|---------|------|-----|-------------|
| **Frontend** | 3000 | http://localhost:3000 | React Dashboard |
| **Backend** | 8000 | http://localhost:8000 | FastAPI Server |
| **API Docs** | 8000 | http://localhost:8000/docs | Swagger UI |
| **MongoDB** | 27017 | - | Database |
| **Redis** | 6379 | - | Cache |

## 🎯 Available Scripts

### Windows

- **`start.bat`** - Start all services
- **`stop.bat`** - Stop all services

### Linux/Mac

- **`./start.sh`** - Start all services
- **`docker-compose down`** - Stop all services

### Universal Commands

```bash
# Start everything
docker-compose up -d

# Stop everything
docker-compose down

# View logs
docker-compose logs -f

# Restart services
docker-compose restart

# Rebuild and restart
docker-compose up -d --build
```

## 📋 Requirements

### Minimum

- **Docker Desktop** (Windows/Mac) or **Docker Engine** (Linux)
- **4 GB RAM**
- **10 GB Disk Space**
- **OpenAI API Key**

### Recommended

- **8 GB RAM**
- **20 GB Disk Space**
- **Stable Internet Connection**

## 🔧 Configuration

### Environment Variables (.env)

```bash
# Required
OPENAI_API_KEY=sk-your-key-here
SECRET_KEY=your-secret-key

# Optional
DEBUG=True
NETWORK_INTERFACE=eth0
MONGODB_URL=mongodb://mongodb:27017
REDIS_HOST=redis
```

### Modify Ports

Edit `docker-compose.yml`:

```yaml
services:
  frontend:
    ports:
      - "3001:3000"  # Change 3001 to your preferred port

  backend:
    ports:
      - "8001:8000"  # Change 8001 to your preferred port
```

## 🎮 Usage Examples

### 1. Start Monitoring

```bash
# Via Dashboard
http://localhost:3000/network

# Via API
curl -X POST http://localhost:8000/api/network-monitor/start
```

### 2. Simulate Attack

```bash
# Via Dashboard
http://localhost:3000/simulator

# Via API
curl -X POST "http://localhost:8000/api/attack-simulator/port-scan?target=127.0.0.1"
```

### 3. AI Analysis

```bash
# Via Dashboard
http://localhost:3000/threats

# Via API
curl -X POST http://localhost:8000/api/ai/analyze \
  -H "Content-Type: application/json" \
  -d '{"type":"port_scan","source_ip":"192.168.1.100"}'
```

## 📊 Monitoring

### View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f mongodb
```

### Container Status

```bash
# Check running containers
docker-compose ps

# Resource usage
docker stats
```

### Health Checks

```bash
# Backend health
curl http://localhost:8000/

# Frontend health
curl http://localhost:3000/

# All agents status
curl http://localhost:8000/api/agents/status
```

## 🔄 Updates

### Update to Latest Version

```bash
# Stop services
docker-compose down

# Pull latest code
git pull

# Rebuild and restart
docker-compose up -d --build
```

## 🗑️ Cleanup

### Stop and Remove Containers

```bash
docker-compose down
```

### Remove All Data (Reset)

```bash
# WARNING: This removes all data!
docker-compose down -v
```

### Full System Cleanup

```bash
# Remove everything (containers, images, volumes)
docker-compose down -v
docker system prune -a --volumes
```

## 🐛 Troubleshooting

### Services Won't Start

**Check Docker is running:**
```bash
docker ps
```

**View error logs:**
```bash
docker-compose logs backend
docker-compose logs frontend
```

### Port Already in Use

**Find process using port:**
```bash
# Windows
netstat -ano | findstr :8000

# Linux/Mac
lsof -i :8000
```

**Change port in docker-compose.yml**

### Can't Access Dashboard

1. **Check if services are running:**
```bash
docker-compose ps
```

2. **Check backend health:**
```bash
curl http://localhost:8000/
```

3. **Check frontend:**
```bash
curl http://localhost:3000/
```

### Database Connection Failed

**Restart MongoDB:**
```bash
docker-compose restart mongodb
```

**Check MongoDB logs:**
```bash
docker-compose logs mongodb
```

### Network Monitoring Not Working

**Check container privileges:**
```bash
docker inspect smas-backend | grep -i privileged
```

Should show: `"Privileged": true`

## 🔐 Security Notes

### Production Deployment

1. **Change default secrets:**
```bash
SECRET_KEY=$(openssl rand -hex 32)
```

2. **Disable debug mode:**
```bash
DEBUG=False
```

3. **Use HTTPS** (see DOCKER_GUIDE.md)

4. **Limit attack simulation:**
```bash
ENABLE_ATTACK_SIM=False
```

### Firewall Configuration

```bash
# Allow only necessary ports
# Backend: 8000
# Frontend: 3000
# MongoDB: 27017 (internal only)
# Redis: 6379 (internal only)
```

## 📚 Documentation

- **Full Guide**: See `DOCKER_GUIDE.md`
- **Installation**: See `INSTALLATION.md`
- **Quick Start**: See `QUICK_START.md`
- **API Docs**: http://localhost:8000/docs

## 🎯 Features

### ✅ Multi-Agent System
- Network Monitor - Real-time packet capture
- Attack Simulator - Port scan, DDoS, Ping sweep
- AI Coordinator - GPT-4 threat analysis
- Automated Response - Block IP, isolate host

### ✅ Dashboard
- Real-time monitoring
- Interactive charts
- Alert management
- Report generation

### ✅ API
- RESTful endpoints
- WebSocket support
- Swagger documentation
- Authentication ready

## 🚀 Advanced Usage

### Custom Docker Compose

Create `docker-compose.override.yml`:

```yaml
version: '3.8'

services:
  backend:
    environment:
      - CUSTOM_SETTING=value
    volumes:
      - ./custom:/custom
```

### Production with Nginx

```bash
# Start with production profile
docker-compose --profile production up -d
```

### Scale Services

```bash
# Run multiple backend instances
docker-compose up -d --scale backend=3
```

## 📞 Support

- Check logs: `docker-compose logs`
- API documentation: http://localhost:8000/docs
- GitHub Issues: (your repo URL)

---

**🎉 Ready to monitor! Start the system and access the dashboard at http://localhost:3000**
